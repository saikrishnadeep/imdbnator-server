# Installation

```sh
cd /root
wget https://github.com/saikrishnadeep/imdbnator-server.git .
bash setup.sh
bash dump.sh
```

# Information

The API server can be built on any debian distro from a fresh droplet or server.

- `setup.sh` - This should run only once on a new server. If you run this on a partially setup stack, then it will upgrade whatever is missing. Further, it makes a fresh clone of the `imdbnator-api` repo and copies it to your root `/srv` folder. **NOTE:** Any existing data in /srv will be deleted
> Installs all the softwares required for first run. Java 8, EKL Stack, MongoDB, NodeJS, python-pip and python-virtualenv.

- `dump.sh` - This script should run everytime there is new dump. It imports the latest dumps in MongoDB and generates the Logstash config.
> Downloads tmdb and movies dump. Validates the dumps using parser.py. Create a special titles dump which will be used for indexing in elasticsearch through Logstash. Drops existing imdb and tmdb collections in MongoDB and imports the new dumps. Finally, Logstash config files are created and the command for indexing the


# Performance

- Official Express performance best practices [here](https://expressjs.com/en/advanced/best-practice-performance.html#do-logging-correctly)


# Elasticsearch

### Bugs

##### `match`

- `Ozhivudivasathe Kali`

##### `prefix`

- `What's eating` works but `Whats eating` doesnt work while searching `What's eating gilbert grape.`
- `Roja` doesnt work.


### Notes

- Cheap Auto-Complete: https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-match-query-phrase-prefix.html
- Completeion suggestor for movies: https://www.elastic.co/guide/en/elasticsearch/reference/current/search-suggesters-completion.html
- More sophisticated search as you type (Required special indexing): https://www.elastic.co/guide/en/elasticsearch/guide/master/_index_time_search_as_you_type.html
- How to perform rolling upgrades for latest elasticsearch: https://www.elastic.co/guide/en/elasticsearch/reference/current/rolling-upgrades.html
- Custom Scoring: https://www.elastic.co/guide/en/elasticsearch/reference/current/query-dsl-function-score-query.html

### Todo

- Need to include apostrophe in searches "Devil's Due" works for exact query but "Devils Due" fails.
- Need to include abbrevations for numbers and symbols like "&" to be recognized as "and"
- Add imdbid and tmdbid indexes after dumping mongo databases
