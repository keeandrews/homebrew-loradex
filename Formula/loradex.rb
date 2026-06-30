class Loradex < Formula
  desc "Git for LoRAs from the command line — discover, train, convert, and publish LoRAs"
  homepage "https://github.com/keeandrews/loradex-cli"
  url "https://github.com/keeandrews/loradex-cli/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "ace22797552d3dd2e4a5303ad9f1f57ca902d3240af0dc0ae7286a4a16fae1f1"
  license "MIT"
  head "https://github.com/keeandrews/loradex-cli.git", branch: "main"

  depends_on "go" => :build

  def install
    ldflags = "-s -w -X github.com/keeandrews/loradex-cli/internal/buildinfo.Version=#{version}"
    system "go", "build", *std_go_args(ldflags: ldflags), "./cmd/loradex"

    generate_completions_from_executable(bin/"loradex", "completion")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/loradex version")
    assert_match "Available Commands", shell_output("#{bin}/loradex --help")
  end
end
