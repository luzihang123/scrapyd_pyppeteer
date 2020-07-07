FROM python:3.8

RUN apt-get update -y && apt-get upgrade -y

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# set display port to avoid crash
ENV DISPLAY=:99

# upgrade pip
RUN pip install --upgrade pip

# 大陆内切换pip源加速
RUN pip config set global.index-url https://mirrors.aliyun.com/pypi/simple/

# MySQL相关依赖
RUN apt-get install libssl-dev libffi-dev libxml2-dev libxslt1-dev zlib1g-dev default-libmysqlclient-dev -y

# 安装中文字体
RUN apt-get install -y locales locales-all -y
RUN apt-get install language-pack-zh* -y
RUN apt-get install chinese* -y

# install
RUN pip install selenium pyppeteer scrapy scrapyd scrapyd-client logparser

ADD . /code
WORKDIR /code
COPY ./scrapyd.conf /etc/scrapyd/
RUN pip install -r requirements.txt

RUN echo "Asia/Shanghai" > /etc/timezone && \
    ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
RUN ["chmod", "777", "entrypoint.sh"]
ENTRYPOINT ["./entrypoint.sh"]
