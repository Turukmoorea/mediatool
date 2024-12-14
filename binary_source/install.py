import os
import shutil

APP_NAME = "mediatool"
LOG_PATH = f"/var/log/{APP_NAME}"
CONFIG_PATH = f"/etc/{APP_NAME}"
USER_CONFIG_PATH = os.path.expanduser(f"~/.config/{APP_NAME}")

def setup_logs():
    """Erstellt das Verzeichnis für Logs."""
    os.makedirs(LOG_PATH, exist_ok=True)
    print(f"Log directory created at {LOG_PATH}")

def setup_configs():
    """Kopiert die globale Config nach /etc/{APP_NAME} und erstellt Benutzer-Config."""
    # Globale Config
    os.makedirs(CONFIG_PATH, exist_ok=True)
    global_config_src = "./binary_source/config/default_config.ini"
    global_config_dest = os.path.join(CONFIG_PATH, "config.ini")
    if not os.path.exists(global_config_dest):
        shutil.copy(global_config_src, global_config_dest)
        print(f"Global config copied to {global_config_dest}")

    # Benutzer-Config
    os.makedirs(USER_CONFIG_PATH, exist_ok=True)
    user_config_dest = os.path.join(USER_CONFIG_PATH, "config.ini")
    if not os.path.exists(user_config_dest):
        shutil.copy(global_config_src, user_config_dest)
        print(f"User config created at {user_config_dest}")

if __name__ == "__main__":
    setup_logs()
    setup_configs()