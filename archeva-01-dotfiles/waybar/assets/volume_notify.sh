#!/bin/bash

# Ícones para as notificações
ICON_VOLUME="/usr/share/icons/Adwaita/symbolic/status/audio-volume-high-symbolic.svg"
ICON_MUTE="/usr/share/icons/Adwaita/symbolic/status/audio-volume-muted-symbolic.svg"

# Limite máximo de volume (100%)
MAX_VOLUME=100

# Verifica a ação passada como argumento
case "$1" in
  up)
    # Obtém o volume atual
    CURRENT_VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | awk -F. '{print $1}')

    # Só aumenta o volume se for menor que 100%
    if [ "$CURRENT_VOLUME" -lt "$MAX_VOLUME" ]; then
      wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
    fi
    ;;
  down)
    # Diminui o volume em 5%
    wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
    ;;
  mute)
    # Alterna entre mudo e não mudo
    wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
    ;;
  *)
    echo "Uso: $0 {up|down|mute}"
    exit 1
    ;;
esac

# Obtém o volume atual e o estado de mudo
VOLUME=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print $2 * 100}' | awk -F. '{print $1}')
MUTED=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | grep -q '\[MUTED\]' && echo "true" || echo "false")

# Define o texto e o ícone para a notificação
if [ "$MUTED" = "true" ]; then
  TEXT="Volume: Muted"
  ICON=$ICON_MUTE
else
  TEXT="Volume: ${VOLUME}%"
  ICON=$ICON_VOLUME
fi

# Check if the icon file exists before sending the notification
if [ ! -f "$ICON" ]; then
  echo "Icon file $ICON not found, using default icon."
  ICON="/usr/share/icons/Adwaita/symbolic/status/audio-volume-high-symbolic.svg" # Default icon
fi

# Envia a notificação com o dunst
echo "$TEXT" | dunstify -i "$ICON" -r 2593 -u low "$TEXT"
