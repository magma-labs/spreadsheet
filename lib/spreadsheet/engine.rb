module Spreadsheet
  class Engine < ::Rails::Engine
    initializer "spreadsheet.webpacker.proxy" do |app|
        insert_middleware = begin
                            Spreadsheet.webpacker.config.dev_server.present?
                          rescue
                            nil
                          end
        next unless insert_middleware

        app.middleware.insert_before(
          0, Webpacker::DevServerProxy,
          ssl_verify_none: true,
          webpacker: Spreadsheet.webpacker
        )
      end

    initializer 'spreadsheet.webpacker.middleware' do |app|
      app.middleware.use(
        Rack::Static,
        urls: ["/spreadheet-packs"],
        root: Spreadsheet::ROOT_PATH.join("public")
      )
    end
  end
end
