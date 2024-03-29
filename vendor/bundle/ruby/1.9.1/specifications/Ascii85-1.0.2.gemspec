# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "Ascii85"
  s.version = "1.0.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Johannes Holzfu\u{c3}\u{9f}"]
  s.date = "2012-09-16"
  s.description = "Ascii85 provides methods to encode/decode Adobe's binary-to-text encoding of the same name."
  s.email = "DataWraith@web.de"
  s.executables = ["ascii85"]
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["bin/ascii85", "README.rdoc", "LICENSE"]
  s.homepage = "http://rubyforge.org/projects/ascii85/"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubyforge_project = "Ascii85"
  s.rubygems_version = "1.8.25"
  s.summary = "Ascii85 encoder/decoder"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_development_dependency(%q<minitest>, [">= 2.6.0"])
      s.add_development_dependency(%q<rake>, [">= 0.9.2"])
    else
      s.add_dependency(%q<bundler>, [">= 1.0.0"])
      s.add_dependency(%q<minitest>, [">= 2.6.0"])
      s.add_dependency(%q<rake>, [">= 0.9.2"])
    end
  else
    s.add_dependency(%q<bundler>, [">= 1.0.0"])
    s.add_dependency(%q<minitest>, [">= 2.6.0"])
    s.add_dependency(%q<rake>, [">= 0.9.2"])
  end
end
