# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

Rails.application.config.assets.precompile += %w[assets/js/lib/jquery.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/jquery.nanoscroller.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/menubar/sidebar.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/preloader/pace.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/calendar-2/moment.latest.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/calendar-2/semantic.ui.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/calendar-2/prism.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/calendar-2/pignose.calendar.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/calendar-2/pignose.init.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/weather/jquery.simpleWeather.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/weather/weather-init.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/circle-progress/circle-progress.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/circle-progress/circle-progress-init.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/chartist/chartist.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/chartist/chartist-init.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/sparklinechart/jquery.sparkline.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/sparklinechart/sparkline.init.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/owl-carousel/owl.carousel.min.js]
Rails.application.config.assets.precompile += %w[assets/js/lib/owl-carousel/owl.carousel-init.js]
Rails.application.config.assets.precompile += %w[assets/js/scripts.js]