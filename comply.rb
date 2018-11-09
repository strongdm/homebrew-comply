class Comply < Formula
  desc "Compliance automation framework, focused on SOC2"
  homepage "https://comply.strongdm.com"
  url "https://github.com/strongdm/comply/archive/v1.3.4.tar.gz"
  sha256 "b8834c29f6f38096a0175d9ded6af02cc16430fc2c59460bfbf1bfa5cff0f38a"

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
    (testpath/"init_comply.sh").write <<~EOS
      #!/usr/bin/expect -f
      set timeout 2
      spawn #{bin}/comply init
      send -- "Hello Corporation\r"
      expect "*Filename Prefix*"
      send -- "\r\r\r"
      expect "*GitHub*"
      send -- "\r"
      expect "*Configure github now*"
      send -- "\r\r"
      expect "+:+"
      send -- "thing\r"
      expect "+:+"
      send -- "thing\r"
      expect "+:+"
      send -- "thing\r"
      expect "+:+"
      send -- "thing\r"
      expect "*Next steps*"
      expect eof
    EOS

    chmod 0755, testpath/"init_comply.sh"
    mkdir testpath/"rundir"

    system "cd rundir && ../init_comply.sh"
    assert_predicate testpath/"rundir/narratives", :exist?
    assert_predicate testpath/"rundir/policies", :exist?
    assert_predicate testpath/"rundir/procedures", :exist?
    assert_predicate testpath/"rundir/standards", :exist?
    assert_predicate testpath/"rundir/templates", :exist?
  end
end
