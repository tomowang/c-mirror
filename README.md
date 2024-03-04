# c-mirror

Mirror site for <https://civitai.com/>. Use [openresty](https://openresty.org/) with lua
to reverse proxy to <https://civitai.com/> and transfrom API responses.

# Dev

Install openresty by <https://openresty.org/en/installation.html>.

```bash
# start openresty
nginx -p `pwd`
# reload openresty service
nginx -p `pwd` -s reload

# test sample model API for original https://civitai.com/api/v1/models/43331
curl http://localhost:8080/api/v1/models/43331
```
