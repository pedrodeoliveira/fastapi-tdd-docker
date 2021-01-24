import nltk
from newspaper import Article

from app.models.tortoise import TextSummary


async def generate_summary(summary_id: int, url: str) -> str:
    article = Article(url)
    article.download()
    article.parse()

    try:
        nltk.data.find("tokenizers/punkt")
    except LookupError:
        nltk.download("punkt")
    finally:
        article.nlp()

    # update the TextSummary db entry identified by the summary_id with the summary
    # obtained from the url article parse
    summary = article.summary
    await TextSummary.filter(id=summary_id).update(summary=summary)
