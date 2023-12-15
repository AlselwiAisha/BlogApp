config.openapi_specs = {
  'v1/swagger.json' => {
    openapi: '3.0.0',
    info: {
      title: 'API V1'
    },
    components: {
      schemas: {
        errors_object: {
          type: 'object',
          properties: {
            errors: { '$ref' => '#/components/schemas/errors_map' }
          }
        },
        errors_map: {
          type: 'object',
          additionalProperties: {
            type: 'array',
            items: { type: 'string' }
          }
        },
        blog: {
          type: 'object',
          properties: {
            id: { type: 'integer' },
            title: { type: 'string' },
            content: { type: 'string', nullable: true },
            thumbnail: { type: 'string', nullable: true }
          },
          required: %w[id title]
        },
        new_blog: {
          type: 'object',
          properties: {
            title: { type: 'string' },
            content: { type: 'string', nullable: true },
            thumbnail: { type: 'string', format: 'binary', nullable: true }
          },
          required: %w[title]
        }
      }
    }
  }
}
