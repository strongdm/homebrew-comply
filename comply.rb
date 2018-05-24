class Comply < Formula
  desc "Compliance automation framework, focused on SOC2"
  homepage "https://comply.strongdm.com"
  url "https://github.com/strongdm/comply/archive/v1.1.27.tar.gz"
  sha256 "b77f4bfce0882e33941661ac78efc5f7f0732e6d5bcd28b8eb45897b99cd8de8"

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
