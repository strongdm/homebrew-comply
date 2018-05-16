class Comply < Formula
    desc "Compliance automation framework, focused on SOC2"
    homepage "https://comply.strongdm.com"
    url "https://github.com/strongdm/comply/archive/v1.1.18.tar.gz"
    sha256 "c872653ea9b9cc603ea68568fdb50c152c8e844a6d34d074887fc4e888165d6a"

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
