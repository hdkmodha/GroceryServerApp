import Fluent
import FluentPostgresDriver
import Vapor
import JWT

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    // app.middleware.use(FileMiddleware(publicDirectory: app.directory.publicDirectory))
    
    //MARK: - Configure Database
    app.databases.use(
        .postgres(configuration:
                .init(
                    hostname: "localhost",
                    port: 5432,
                    username: "admin",
                    password: "admin",
                    database: "grocerydb",
                    tls: .disable),
                  decodingContext: .default),
        as: .psql)
    
    //MARK: - Register Migrations
    app.migrations.add(CreateUsersTableMigration())
    app.migrations.add(CreateGroceryCategoryTableMirgration())
    
    //Register Controller
    try app.register(collection: UserController())
    try app.register(collection: GroceryController())
    await app.jwt.keys.add(hmac: "secret", digestAlgorithm: .sha256)
    
    //Middlewares
    app.middleware.use(CustomErrorMiddleware())

    // register routes
    try routes(app)
}
