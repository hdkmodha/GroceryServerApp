import Fluent
import FluentPostgresDriver
import Vapor

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

    // register routes
    try routes(app)
}
