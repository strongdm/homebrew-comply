class Comply < Formula
  desc "Compliance automation framework, focused on SOC2"
  homepage "https://comply.strongdm.com"
  url "https://github.com/strongdm/comply/archive/v1.1.25.tar.gz"
  sha256 "f200b7d64d6b96325dc2fa03814e81ba0836dcf8b50f91560887d220c8b3ee9e"

  depends_on "go" => :build

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
