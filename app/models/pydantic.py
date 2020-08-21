# noinspection PyPackageRequirements
from pydantic import BaseModel


class SummaryPayloadSchema(BaseModel):
    url: str


class SummaryResponseSchema(SummaryPayloadSchema):
    id: int
