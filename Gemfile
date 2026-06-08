source "https://rubygems.org"

# Modern Jekyll (built in CI on Ruby 3.x via .github/workflows/jekyll.yml).
# This escapes the old, version-locked `github-pages` gem.
gem "jekyll", "~> 4.3"

group :jekyll_plugins do
  gem "jekyll-feed", "~> 0.17"
  gem "jekyll-seo-tag", "~> 2.8"
  gem "jekyll-sitemap", "~> 1.4"
end

# Local preview server (Ruby 3 dropped webrick from stdlib).
gem "webrick", "~> 1.8"

# Boot speed + Windows compatibility.
gem "bigdecimal"            # extracted from stdlib in Ruby 3.4+
gem "csv"                   # extracted from stdlib in Ruby 3.4+
gem "base64"               # extracted from stdlib in Ruby 3.4+
gem "logger"               # extracted from stdlib in Ruby 3.5+

platforms :mingw, :x64_mingw, :mswin, :jruby do
  gem "tzinfo", ">= 1", "< 3"
  gem "tzinfo-data"
end

gem "wdm", "~> 0.1.1", :platforms => [:mingw, :x64_mingw, :mswin]
