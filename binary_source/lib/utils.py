import logging
import os
import sys


# Global CLI options
COMMON_OPTIONS = {
    "source": {"short": "-s", "long": "--source", "help": "Path to the input file or directory."},
    "target": {"short": "-t", "long": "--target", "help": "Path to the output file or directory."},
    "log_level": {"short": "-l", "long": "--log-level", "help": "Set the log level (DEBUG, INFO, WARNING, ERROR)."},
    "recursive": {"short": "-r", "long": "--recursive", "help": "Process directories recursively."},
    "quiet": {"short": "-q", "long": "--quiet", "help": "Suppress all output except errors."},
    "dry_run": {"short": "-d", "long": "--dry-run", "help": "Simulate the operation without making changes."},
    "config": {"short": "-c", "long": "--config", "help": "Path to a configuration file."},
    "help": {"short": "-h", "long": "--help", "help": "Show the help message."},
}

def setup_logging(log_level="INFO", log_file=None):
    """
    Sets up the logging configuration for the project.
    :param log_level: Logging level as string (DEBUG, INFO, WARNING, ERROR, CRITICAL).
    :param log_file: Path to a log file (optional).
    """
    numeric_level = getattr(logging, log_level.upper(), None)
    if not isinstance(numeric_level, int):
        raise ValueError(f"Invalid log level: {log_level}")

    logging.basicConfig(
        level=numeric_level,
        format="%(asctime)s - %(levelname)s - %(message)s",
        handlers=[
            logging.FileHandler(log_file) if log_file else logging.StreamHandler(sys.stdout)
        ]
    )
    logging.info(f"Logging initialized at level: {log_level}")


def validate_path(path, is_directory=False):
    """
    Validates if a path exists and matches the type (file or directory).
    :param path: Path to validate.
    :param is_directory: If True, checks for a directory; otherwise, checks for a file.
    :return: True if the path is valid, otherwise raises an exception.
    """
    if not path:
        raise ValueError("Path is not specified.")

    if not os.path.exists(path):
        raise FileNotFoundError(f"Path not found: {path}")

    if is_directory and not os.path.isdir(path):
        raise ValueError(f"Expected a directory but found a file: {path}")

    if not is_directory and not os.path.isfile(path):
        raise ValueError(f"Expected a file but found a directory: {path}")

    return True


def ensure_output_directory(output_dir):
    """
    Ensures that the output directory exists. If not, it creates it.
    :param output_dir: Path to the output directory.
    """
    if not os.path.exists(output_dir):
        logging.info(f"Creating output directory: {output_dir}")
        os.makedirs(output_dir)
    else:
        logging.info(f"Output directory already exists: {output_dir}")


def parse_config_file(config_path):
    """
    Parses a configuration file and returns the content as a dictionary.
    :param config_path: Path to the configuration file.
    :return: Dictionary with configuration data.
    """
    if not os.path.exists(config_path):
        raise FileNotFoundError(f"Configuration file not found: {config_path}")

    config = {}
    with open(config_path, "r") as file:
        for line in file:
            line = line.strip()
            if line and not line.startswith("#"):  # Ignore empty lines and comments
                key, value = line.split("=", 1)
                config[key.strip()] = value.strip()
    return config
