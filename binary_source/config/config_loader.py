from configparser import ConfigParser
import os
from binary_source.config.default_config import (
    CONFIG_PATH,
    DEFAULT_GLOBAL_CONFIG_PATH,
    DEFAULT_USER_CONFIG_PATH,
)

def load_config(env=None):
    """
    Lädt die Konfiguration basierend auf dem App-Status.
    - `development`: Entwicklungsconfigs aus ./dev/config/dev_config.ini.
    - `production`: Globale und Benutzerkonfigurationen.
    - Standard: CONFIG_PATH aus default_config.py.
    """
    # Wenn keine Umgebung übergeben wird, prüfen wir die Umgebungsvariable
    if env is None:
        env = os.getenv("APP_STATUS", "production")

    config = ConfigParser()

    if env == "development":
        # Entwicklungsmodus: Lade Entwicklungsconfig
        dev_config_path = "./dev/config/dev_config.ini"
        if os.path.exists(dev_config_path):
            config.read(dev_config_path)
        else:
            raise FileNotFoundError(f"Development config not found: {dev_config_path}")
    elif env == "alpha":
        # Alpha-Staging-Config
        lab_config_path = "./lab/config/lab_config.ini"
        if os.path.exists(lab_config_path):
            config.read(lab_config_path)
        else:
            raise FileNotFoundError(f"Alpha config not found: {lab_config_path}")
    elif env == "production":
        # Produktionsmodus: Lade globale und Benutzerkonfigurationen
        if os.path.exists(DEFAULT_GLOBAL_CONFIG_PATH):
            config.read(DEFAULT_GLOBAL_CONFIG_PATH)
        else:
            raise FileNotFoundError(f"Global config not found: {DEFAULT_GLOBAL_CONFIG_PATH}")

        # Benutzerkonfiguration
        user_config_path = os.path.expanduser(DEFAULT_USER_CONFIG_PATH)
        if os.path.exists(user_config_path):
            config.read(user_config_path)
    else:
        raise ValueError(f"Unknown environment: {env}")

    return config
