


> [![Deploy](https://www.herokucdn.com/deploy/button.png)](https://dashboard.heroku.com/new?template=https://github.com/Clown1i/heroku)



### CloudFlare Workers反代代码
<details>
<summary>CloudFlare Workers单账户反代代码</summary>

```js
addEventListener(
    "fetch",event => {
        let url=new URL(event.request.url);
        url.hostname="appname.herokuapp.com";
        let request=new Request(url,event.request);
        event. respondWith(
            fetch(request)
        )
    }
)
```
</details>


<details>
<summary>CloudFlare Workers多账户轮换反代代码</summary>

```js
const Day0 = 'app0.herokuapp.com'
const Day1 = 'app1.herokuapp.com'
const Day2 = 'app2.herokuapp.com'
const Day3 = 'app3.herokuapp.com'
const Day4 = 'app4.herokuapp.com'
addEventListener(
    "fetch",event => {
    
        let nd = new Date();
        let day = nd.getDate() % 5;
        if (day === 0) {
            host = Day0
        } else if (day === 1) {
            host = Day1
        } else if (day === 2) {
            host = Day2
        } else if (day === 3){
            host = Day3
        } else if (day === 4){
            host = Day4
        } else {
            host = Day1
        }
        
        let url=new URL(event.request.url);
        url.hostname=host;
        let request=new Request(url,event.request);
        event. respondWith(
            fetch(request)
        )
    }
)
```
</details>


<details>
<summary>CloudFlare Pages多账户轮换反代代码</summary>

```js
export default {
    async fetch(request, env) {
		let url = new URL(request.url);	
		let nd = new Date();
        let day = nd.getDate() % 6;
		if (day === 0) {
            url.hostname="heroku-u1.herokuapp.com";
        } else if (day === 1) {
            url.hostname="heroku-u2.herokuapp.com";
        } else if (day === 2) {
            url.hostname="heroku-u3.herokuapp.com";
        } else if (day === 3) {
            url.hostname="heroku-u4.herokuapp.com";
        } else if (day === 4) {
            url.hostname="heroku-u5.herokuapp.com";
        } else if (day === 5) {
            url.hostname="heroku-u6.herokuapp.com";
        } else{
            url.hostname="heroku-u1.herokuapp.com";
        }
        let new_request=new Request(url,request);
		return fetch(new_request);
    }
  };
```
</details>


<details>
<summary>CloudFlare Pages反代</summary>

```js
export default {
    async fetch(request, env) {
	let url = new URL(request.url);	
        url.hostname=env.REACT_APP_FORM_HOSTNAME;
        url.pathname=env.REACT_APP_FORM_PATH;
        url.search=env.REACT_APP_FORM_SEARCH;
        let new_request=new Request(url,request);
	return fetch(new_request);
    }
  };
  
  //将文件名改为_worker.js上传部署

```
</details>


<details>
<summary>CloudFlare Workers反代</summary>

```js
addEventListener(
    "fetch",event => {
        let url=new URL(event.request.url);
        url.hostname=REACT_APP_FORM_HOSTNAME;
        url.pathname=REACT_APP_FORM_PATH;
        url.search=REACT_APP_FORM_SEARCH;
        let request=new Request(url,event.request);
        event. respondWith(fetch(request))
    }
)
    
```
</details>


<details>
<summary>CloudFlare Workers自建测速网站代码</summary>

```js
addEventListener("fetch", event => {
  let url = new URL(event.request.url);
  url.protocol = 'https:'
  url.hostname = "cachefly.cachefly.net";
  let request = new Request(url, event.request);
  event.respondWith(fetch(request));
})

```
</details>

