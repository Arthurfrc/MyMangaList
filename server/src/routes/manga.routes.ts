// 200 = OK
// 201 = Created
// 202 = Accepted
// 400 = Bad Request
// 401 = Unauthorized
// 402 = Payment Required
// 403 = Forbidden
// 404 = Not Found
// 500 = Internal Server Error
// 501 = Not Implemented
// 502 = Bad Gatewayimport { FastifyInstance, FastifyRequest } from 'fastify'

import { FastifyInstance } from 'fastify'
import { z } from 'zod'

import { prisma } from '../lib/prisma'

interface MangaRequestBody {
  name?: string
  link?: string
  lastRead?: number
}

interface RouteParams {
  id: number
}

export async function mangasRoutes (fastify: FastifyInstance) {
  const item = z.object({
    name: z.string(),
    link: z.string().nullable(),
    lastRead: z.number().nullable()
  })
  // Contar / Pesquisar Mangás
  fastify.post<{ Body: MangaRequestBody }>(
    '/manga/list',
    async (req, reply) => {
      try {
        const search = req.body.name
        let resultado = {}

        let where = {}
        if (search) {
          where = { name: { contains: search } }
          resultado = await prisma.manga.findMany({ where: where })
        } else {
          resultado = await prisma.manga.findMany({})
        }

        const count = await prisma.manga.count({ where: where })

        reply.code(200).send({ count, resultado })
      } catch (error) {
        reply.status(400).send({ error: error })
      }
    }
  )

  // Cadastrar mangá
  fastify.post<{ Body: MangaRequestBody & { userId?: number } }>(
    '/manga/new',
    async (req, reply) => {
      const { name, link, lastRead } = item.parse(req.body)

      const response = await prisma.manga.create({
        data: {
          name,
          link,
          lastRead
        }
      })

      reply.code(201).send({})
      return { response }
    }
  )

  // Editar último lido
  fastify.put<{ Body: MangaRequestBody; Params: RouteParams }>(
    '/manga/:id',
    async (req, reply) => {
      const id: number = req.params.id
      const last = await prisma.manga.findUnique({ where: { id } })

      if (!last) {
        throw new Error('Manga not found')
      }

      let data = {
        name: req.body.name !== undefined ? req.body.name : undefined,
        link: req.body.link !== undefined ? req.body.link : undefined,
        lastRead:
          req.body.lastRead !== undefined ? req.body.lastRead : undefined
      }
      const updateManga = await prisma.manga.update({
        where: { id },
        data
      })

      reply.code(200).send(['Manga atualizado com sucesso', { updateManga }])
    }
  )
}
