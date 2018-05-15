class Comply < Formula
    desc "Compliance automation framework, focused on SOC2"
    homepage "https://comply.strongdm.com"
    url "https://github.com/strongdm/comply/archive/v1.1.16.tar.gz"
    sha256 "7f14fed4724c00634e94a0232b819fa8407bfa1aa6b1e539ce0ecbc826d10060"

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
