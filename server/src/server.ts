import 'dotenv/config'
import Fastify from 'fastify'
import { mangasRoutes } from './routes/manga.routes'

async function bootstrap () {
  const fastify = Fastify({ logger: true })

  await fastify.register(mangasRoutes)

  await fastify
    .listen({
      port: 3333,
      host: '0.0.0.0'
    })
    .then(() => {
      'Listening on port 3333'
    })
}

bootstrap()
