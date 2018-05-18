class Comply < Formula
    desc "Compliance automation framework, focused on SOC2"
    homepage "https://comply.strongdm.com"
    url "https://github.com/strongdm/comply/archive/v1.1.19.tar.gz"
    sha256 "f7d670d282a988a11e10cd1d9a857664d38d5deb08f8da8654052125185d961e"

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
