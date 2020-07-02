scrapyd_pyppeteer：包含 python3.8 selenium pyppeteer scrapy scrapyd scrapyd-client logparser
可以用于scrapydweb的scrapyd节点，使用pyppeteer，在[scrapy中异步使用](https://www.jianshu.com/p/aeb9a7adcfa8)


测试代码:
```python
import asyncio
from pyppeteer import launch

async def main():
    browser = await launch(headless=True,args=['--no-sandbox', '--disable-dev-shm-usage'])
    
    page = await browser.newPage()
    await page.setViewport(viewport={'width': 1280, 'height': 800})
    await page.setExtraHTTPHeaders(
        {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_5) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.116 Safari/537.36'}
        )
    # await page.goto('http://www.jcfc.cn/')
    # await page.goto('https://httpbin.org/get')
    await page.goto('https://news.baidu.com/')
    # await page.screenshot(path='example.png', fullPage=True)
    await asyncio.sleep(5)
    return await page.content()

res = asyncio.get_event_loop().run_until_complete(main())
print(res)
```

![NqN5nS.png](https://s1.ax1x.com/2020/07/02/NqN5nS.png)

scrapyd启动日志：
```shell
2020/7/2 下午5:41:46[2020-07-02 17:41:46,768] INFO     in logparser.run: LogParser version: 0.8.2
2020/7/2 下午5:41:46[2020-07-02 17:41:46,769] INFO     in logparser.run: Use 'logparser -h' to get help
2020/7/2 下午5:41:46[2020-07-02 17:41:46,769] INFO     in logparser.run: Main pid: 10
2020/7/2 下午5:41:46[2020-07-02 17:41:46,769] INFO     in logparser.run: Check out the config file below for more advanced settings.
2020/7/2 下午5:41:46
2020/7/2 下午5:41:46****************************************************************************************************
2020/7/2 下午5:41:46Loading settings from /usr/local/lib/python3.8/site-packages/logparser/settings.py
2020/7/2 下午5:41:46****************************************************************************************************
2020/7/2 下午5:41:46
2020/7/2 下午5:41:46[2020-07-02 17:41:46,770] DEBUG    in logparser.run: Reading settings from command line: Namespace(delete_json_files=True, disable_telnet=False, main_pid=0, scrapyd_logs_dir='/code/logs', scrapyd_server='127.0.0.1:6800', sleep='10', verbose=False)
2020/7/2 下午5:41:46[2020-07-02 17:41:46,770] DEBUG    in logparser.run: Checking config
2020/7/2 下午5:41:46[2020-07-02 17:41:46,770] INFO     in logparser.run: SCRAPYD_SERVER: 127.0.0.1:6800
2020/7/2 下午5:41:46[2020-07-02 17:41:46,770] ERROR    in logparser.run: Check config fail:
2020/7/2 下午5:41:46
2020/7/2 下午5:41:46SCRAPYD_LOGS_DIR not found: '/code/logs'
2020/7/2 下午5:41:46Check and update your settings in /usr/local/lib/python3.8/site-packages/logparser/settings.py
2020/7/2 下午5:41:46
2020/7/2 下午5:41:472020-07-02T17:41:46+0800 [-] Loading /usr/local/lib/python3.8/site-packages/scrapyd/txapp.py...
2020/7/2 下午5:41:472020-07-02T17:41:47+0800 [-] Scrapyd web console available at http://0.0.0.0:6800/
2020/7/2 下午5:41:472020-07-02T17:41:47+0800 [-] Loaded.
2020/7/2 下午5:41:472020-07-02T17:41:47+0800 [twisted.scripts._twistd_unix.UnixAppLogger#info] twistd 18.9.0 (/usr/local/bin/python 3.8.3) starting up.
2020/7/2 下午5:41:472020-07-02T17:41:47+0800 [twisted.scripts._twistd_unix.UnixAppLogger#info] reactor class: twisted.internet.epollreactor.EPollReactor.
2020/7/2 下午5:41:472020-07-02T17:41:47+0800 [-] Site starting on 6800
2020/7/2 下午5:41:472020-07-02T17:41:47+0800 [twisted.web.server.Site#info] Starting factory <twisted.web.server.Site object at 0x7f680d7bf790>
2020/7/2 下午5:41:472020-07-02T17:41:47+0800 [Launcher] Scrapyd 1.2.0 started: max_proc=200, runner='scrapyd.runner'
```
