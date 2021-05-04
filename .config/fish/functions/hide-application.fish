function hide-application
  set APP_NAME "$argv[1]"
  set APP_SRC_PATH "/usr/share/applications"
  set APP_DEST_PATH "$HOME/.local/share/applications"

  cp "$APP_SRC_PATH/$APP_NAME" "$APP_DEST_PATH"
  echo "NoDisplay=true" >> "$APP_DEST_PATH/$APP_NAME"
end
