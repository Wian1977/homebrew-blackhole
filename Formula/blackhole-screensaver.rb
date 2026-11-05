class BlackholeScreensaver < Formula
  desc "Real-physics Schwarzschild black-hole OpenGL screensaver"
  homepage "https://github.com/Wian1977/blackholescreensaver"
  url "https://github.com/Wian1977/blackholescreensaver/archive/refs/tags/v1.1.0.tar.gz"
  sha256 "7bf957d62976dcea1f521cf6c8ad99be51f3c6dc626758c850c8e0c7db0d867b"
  license "MIT"

  def install
    libexec.install Dir["*.py"], Dir["*.bin"], "plugin"
    (bin/"blackhole-screensaver").write <<~SH
      #!/bin/sh
      exec python3 "#{libexec}/bh_gl.py" "$@"
    SH
    (bin/"blackhole-daemon").write <<~SH
      #!/bin/sh
      exec python3 "#{libexec}/blackhole-daemon.py" "$@"
    SH
  end

  def caveats
    <<~EOS
      Uses the system python3. Requires PyGObject (gi), GTK3 and Mesa/OpenGL:
        sudo apt install python3-gi gir1.2-gtk-3.0 python3-xlib libgl1-mesa-dri
      Then run: blackhole-screensaver --windowed
    EOS
  end

  test do
    assert_predicate bin/"blackhole-screensaver", :exist?
  end
end
