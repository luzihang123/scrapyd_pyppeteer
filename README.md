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
