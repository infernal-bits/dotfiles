if not contains "$HOME/.local/share/krita/ai_diffusion/server/uv" $PATH
    # Prepending path in case a system-installed binary needs to be overridden
    set -x PATH "$HOME/.local/share/krita/ai_diffusion/server/uv" $PATH
end
