# Oh My Posh
eval "$(oh-my-posh init bash --config $(brew --prefix oh-my-posh)/themes/tokyonight_storm.omp.json)"
# Java Home
export JAVA_HOME=/usr/lib/jvm/java-21-openjdk
# Deno
. "/home/<USERNAME_HERE>/.deno/env"
source /home/<USERNAME_HERE>/.local/share/bash-completion/completions/deno.bash
# Android
export ANDROID_HOME=$HOME/Android/Sdk
export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
