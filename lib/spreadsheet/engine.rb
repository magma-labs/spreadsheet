module Spreadsheet
  class Engine < ::Rails::Engine
    initializer "webpacker.proxy" do |app|
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
  end
end
