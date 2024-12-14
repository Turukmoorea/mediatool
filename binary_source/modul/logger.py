import logging
import sys
from configparser import ConfigParser
from binary_source.config.config_loader import load_config  # Importiere die Konfigurationslogik

class PosixLogger:
    """
    A class that sets up a POSIX-compliant logger. This logger:
    - Sends DEBUG, INFO, and WARNING logs to STDOUT.
    - Sends ERROR and CRITICAL logs to STDERR.
    - Optionally writes all logs to a file, based on configuration.
    """

    def __init__(self, level=None, log_path=None):
        """
        Initializes the logger with configurable logging level and file output.

        :param level: The minimum logging level (default is None, and will be loaded from config).
        :param log_path: Optional file path for logging.
        """
        # Load configuration
        config = load_config()  # Lädt die Konfiguration (z. B. aus dev_config.ini, etc.)
        level = level or getattr(logging, config.get("logging", "level", fallback="INFO").upper())
        log_path = log_path or config.get("logging", "path", fallback=None)

        # Create a logger instance with a specific name
        self.logger = logging.getLogger("PosixLogger")
        self.logger.setLevel(level)  # Set the overall logging level (e.g., DEBUG, INFO, WARNING)

        # Ensure no duplicate handlers are added if this is called multiple times
        if self.logger.hasHandlers():
            self.logger.handlers.clear()

        # Create a handler for STDOUT (DEBUG, INFO, WARNING logs)
        stdout_handler = logging.StreamHandler(sys.stdout)
        stdout_handler.setLevel(logging.DEBUG)
        stdout_handler.addFilter(self._stdout_filter())  # Filter for STDOUT
        stdout_handler.setFormatter(self._get_formatter())

        # Create a handler for STDERR (ERROR, CRITICAL logs)
        stderr_handler = logging.StreamHandler(sys.stderr)
        stderr_handler.setLevel(logging.ERROR)
        stderr_handler.setFormatter(self._get_formatter())

        # Optionally add a file handler if a log path is provided
        if log_path:
            file_handler = logging.FileHandler(log_path, mode="a")  # Append logs to the file
            file_handler.setLevel(logging.DEBUG)  # File handler logs everything from DEBUG and above
            file_handler.setFormatter(self._get_formatter())
            self.logger.addHandler(file_handler)

        # Add the handlers to the logger instance
        self.logger.addHandler(stdout_handler)
        self.logger.addHandler(stderr_handler)

    def _get_formatter(self):
        """
        Creates and returns a log message formatter.

        :return: A `logging.Formatter` instance with a predefined format.
        """
        return logging.Formatter(
            fmt="%(asctime)s [%(levelname)s] %(message)s",
            datefmt="%Y-%m-%d %H:%M:%S"
        )

    def _stdout_filter(self):
        """
        Creates a filter for STDOUT to exclude ERROR and CRITICAL messages.

        :return: A custom logging filter.
        """

        class StdoutFilter(logging.Filter):
            def filter(self, record):
                # Allow DEBUG, INFO, and WARNING levels
                return record.levelno < logging.ERROR

        return StdoutFilter()

    def get_logger(self):
        """
        Returns the configured logger instance.

        :return: A `logging.Logger` instance.
        """
        return self.logger


# Function for central logging setup
def setup_logging():
    """
    Initializes and returns a POSIX-compliant logger based on configuration.

    This function creates a `PosixLogger` instance with values loaded from the configuration file.

    :return: A `logging.Logger` instance.
    """
    posix_logger = PosixLogger()  # Initialize the custom logger
    return posix_logger.get_logger()  # Return the logger instance
