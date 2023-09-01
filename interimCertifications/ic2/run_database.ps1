# -v ${PWD}:/docker-entrypoint-initdb.d ^ # для мапинга каталога со скриптами инициализации
docker run `
    --name ic2database `
    -e POSTGRES_PASSWORD=ic2database `
    -p 5432:5432 `
    -v ${PWD}/database_init:/docker-entrypoint-initdb.d `
    -d `
    postgres:15.1