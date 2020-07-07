# Wordpress

## REST API

### 404 for endpoints, e.g. `/wp/v2/posts`

Following [this SO post](https://stackoverflow.com/questions/34670533/wordpress-rest-api-wp-api-404-error), I found that I had to prepend `/index.php/wp-json` to the endpoint, e.g. `curl -u "$CRED" -v -k https://academy.io.com/index.php/wp-json/wp/v2/posts`
