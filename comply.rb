class Comply < Formula
  desc "Compliance automation framework, focused on SOC2"
  homepage "https://comply.strongdm.com"
  url "https://github.com/strongdm/comply/archive/v1.2.0.tar.gz"
  sha256 "f04accca79f20cd67fa10290ecc3dcc6bdcafa3137484d83edff2fcf40b27b6d"

  depends_on "go" => :build
  depends_on "pandoc"

  def install
    ENV["GOPATH"] = buildpath
    ENV.prepend_create_path "PATH", buildpath/"bin"
    (buildpath/"src/github.com/strongdm/comply").install buildpath.children
    cd "src/github.com/strongdm/comply" do
      system "make", "brew"
      bin.install "bin/comply"
    end
  end

  test do
    system "#{bin}/sdm", "logout"
  end
end
