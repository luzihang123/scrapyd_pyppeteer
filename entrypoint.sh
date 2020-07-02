#!/bin/bash
logparser -dir /code/logs -t 10 --delete_json_files & scrapyd
