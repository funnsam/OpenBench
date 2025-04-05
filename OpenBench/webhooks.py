import requests

wh_id = None
wh_token = None

def test_finished(test):
    if wh_id is None or wh_token is None:
        return

    requests.post(
        f"https://discord.com/api/webhooks/{wh_id}/{wh_token}",
        data = {
            "content": f"{test} finished (passed: {test.passed}, failed: {test.failed})",
        },
    )
