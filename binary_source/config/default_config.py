import os

# Globale Standardpfade
DEFAULT_GLOBAL_CONFIG_PATH = "/etc/mediatool/config.ini"  # Produktionskonfiguration
DEFAULT_USER_CONFIG_PATH = os.path.expanduser("~/.config/mediatool/config.ini")  # Benutzerspezifische Konfiguration
DEFAULT_LOGGING_PATH = "/var/log/mediatool/app.log"  # Produktionslog

# Standard App-Status (Umgebungsvariable oder "release" als Fallback)
APP_STATUS = os.getenv("APP_STATUS", "dev").lower()

# Konfigurations- und Logpfade basierend auf dem Status
if APP_STATUS == "dev":
    CONFIG_PATH = "./dev/config/dev_config.ini"  # Entwicklungsconfig
    LOG_PATH = "./dev/log/app.log"  # Entwicklungslog
elif APP_STATUS == "alpha":
    CONFIG_PATH = "./lab/config/lab_config.ini"  # Staging-/Labconfig
    LOG_PATH = "./lab/log/app.log"  # Lablog
elif APP_STATUS == "release":
    CONFIG_PATH = DEFAULT_GLOBAL_CONFIG_PATH  # Produktionsconfig
    LOG_PATH = DEFAULT_LOGGING_PATH  # Produktionslog
else:
    raise ValueError(f"Unknown APP_STATUS: {APP_STATUS}. Valid options: 'dev', 'alpha', 'release'.")

# Weitere Standardwerte (gültig für alle Modi)
DEFAULT_TIMEOUT = 30  # Timeout in Sekunden
DEFAULT_RETRIES = 3  # Maximale Anzahl von Wiederholungsversuchen
