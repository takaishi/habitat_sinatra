plg_oriigin=origin
pkg_name=habitat_sinatra_sample
pkg_version=0.0.1
pkg_maintainer="Takaishi Ryo <ryo.takaishi.0@gmail.com>"
pkg_license=()
pkg_source=https://github.com/takaishi/${pkg_name}/archive/${pkg_version}.tar.gz
pkg_shasum=2977dff904580d64f72a833e9ce228fdff19ea6956aba36a5d8000ddd9ffe4c7
pkg_filename==${pkg_version}.tar.gz
pkg_deps=(core/ruby core/bundler core/bash)
pkg_build_deps=(core/ruby core/bundler core/bash)
pkg_lib_dirs=(lib)
pkg_include_dirs=(include)
pkg_expose=(8080)
pkg_bin_dirs=(bin vendor/bundle/bin)

do_install() {
  cp Gemfile ${pkg_prefix}
  cp Gemfile.lock ${pkg_prefix}
  cp app.rb ${pkg_prefix}
  cp -r .bundle ${pkg_prefix}
  cp -r vendor ${pkg_prefix}
}

do_build() {
  local _bundler_dir=$(pkg_path_for bundler)

  export GEM_HOME=${pkg_path}/vendor/bundle
  export GEM_PATH=${_bundler_dir}:${GEM_HOME}
  gem install bundler -v 1.11.2 --no-ri --no-rdoc
  bundle install --path vendor/bundle
}
