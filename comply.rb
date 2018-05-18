class Comply < Formula
    desc "Compliance automation framework, focused on SOC2"
    homepage "https://comply.strongdm.com"
    url "https://github.com/strongdm/comply/archive/v1.1.20.tar.gz"
    sha256 "f42a05a4762b05edb09121a096a270e6f535a6e2833eb50c89b9654905eb1670"

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
