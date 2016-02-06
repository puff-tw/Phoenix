# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = '1.0'

# Add additional assets to the asset load path
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('app', 'assets', 'fonts')
Rails.application.config.assets.precompile += %w( *.svg *.eot *.woff *.woff2 *.ttf *.swf *.js application.css scaffolds.scss)

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in app/assets folder are already added.
Rails.application.config.assets.precompile += %w( pos_invoices.js inventory_out_vouchers.js inventory_in_vouchers.js inventory_internal_transfer_vouchers.js journal_vouchers.js print.css )
