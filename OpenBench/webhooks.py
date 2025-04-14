import requests

url = "https://funnsam.pythonanywhere.com"
wh_id = None
wh_token = None

def test_finished(test_id, test):
    if wh_id is None or wh_token is None:
        return

    requests.post(
        f"https://discord.com/api/webhooks/{wh_id}/{wh_token}",
        data = {
            "content": f"\
`{test}` {'passed' if test.passed else ('failed' if test.failed else 'finished')} \
([view on OpenBench]( {url}/test/{test_id} ))",
        },
    )
