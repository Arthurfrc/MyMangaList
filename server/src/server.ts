import fastify from 'fastify'
import cors from 
import { PrismaClient } from '@prisma/client'

const app = fastify()
const prisma = new PrismaClient()

app.get('/listar', async () => {
	const lista = await prisma.manga.count()

  return lista
})

app
  .listen({
    port: 3333
  })
  .then(() => {
    console.log('HTTP server running!')
  })
