from sqlalchemy import Column, DateTime, ForeignKey, Integer, String, Text
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import relationship
from sqlalchemy.sql import func
# from fastapi_utils.guid_type import GUID, GUID_DEFAULT_SQLITE

Base = declarative_base()

class Image(Base):
    __tablename__ = "image"
    id = Column(Integer, primary_key=True, index=True)
    text = Column(Text, nullable=True)
    file_ext = Column(String, nullable=False, default='')
    original_file_name = Column(Text, nullable=False)
    time_created = Column(DateTime(timezone=True), server_default=func.now())
    uuid = Column(String, nullable=False)
