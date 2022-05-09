function hide-application
  set APP_NAME "$argv[1]"
  set APP_SRC_PATH "/usr/share/applications"
  set APP_DEST_PATH "$HOME/.local/share/applications"

  if test ! -f "$APP_DEST_PATH/$APP_NAME"
    cp "$APP_SRC_PATH/$APP_NAME" "$APP_DEST_PATH"
    chmod u+w "$APP_DEST_PATH/$APP_NAME"
    echo "NoDisplay=true" >> "$APP_DEST_PATH/$APP_NAME"
  end
end
