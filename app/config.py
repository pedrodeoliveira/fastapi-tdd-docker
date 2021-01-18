import logging
import os
from functools import lru_cache

# noinspection PyPackageRequirements
from pydantic import AnyUrl, BaseSettings

log = logging.getLogger(__name__)


class Settings(BaseSettings):
    environment: str = os.getenv("ENVIRONMENT", "dev")
    testing: bool = os.getenv("TESTING", 0)
    database_url: AnyUrl = os.getenv("DATABASE_URL")


@lru_cache()
def get_settings() -> BaseSettings:
    log.info("Loading config settings from the environment...")
    return Settings()
