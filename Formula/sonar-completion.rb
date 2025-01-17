class SonarCompletion < Formula
  desc "Bash completion for Sonar"
  homepage "https://github.com/a1dutch/sonarqube-bash-completion"
  url "https://github.com/a1dutch/sonarqube-bash-completion/archive/1.1.tar.gz"
  sha256 "506a592b166cff88786ae9e6215f922b8ed3617c65a4a88169211a80ef1c6b66"
  license "Apache-2.0"
  head "https://github.com/a1dutch/sonarqube-bash-completion.git", branch: "master"

  def install
    bash_completion.install "etc/bash_completion.d/sonar"
  end

  test do
    assert_match "-F _sonar",
      shell_output("source #{bash_completion}/sonar && complete -p sonar")
  end
end
