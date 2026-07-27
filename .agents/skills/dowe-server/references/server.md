# Server reference

## Named server declarations

| Declaration | Binding role | Responsibility |
| --- | --- | --- |
| `endpoints apiRoutes` | Importable route graph | Connects handlers and middleware to paths |
| `handler registerUser` | Importable HTTP boundary | Parses requests and returns responses; `req` and asynchronous execution are implicit |
| `middleware requireBearer` | Importable request boundary | Validates or enriches request context |
| `fn sendMail params:{...}` | Importable reusable function | Owns provider, service, repository, task, or utility behavior |
| `database primaryDb provider:"dowe" ...` | Reusable Database connection | Imported config binding or server action connection |
| `entity User` | Importable Database schema | Declares fields and constraints for SQL migrations |
| `seeder Bootstrap` | Importable seed data | Declares static inserts applied once by fingerprint |
| `cache appCache provider:"dowe" ...` | Reusable Cache connection | Imported config binding or server action connection |
| `vector appVector provider:"dowe" ...` | Reusable Vector connection | Imported config binding or server action connection |

Handlers call service functions. `req` is implicit inside every HTTP handler, so route parameters,
request metadata, middleware context, and the typed JSON declaration can use `req` directly.
Service functions may call providers, repositories, tasks, or utilities. Repository functions own Database, Cache, and Vector logic. `service` and `repository` are not
declaration keywords. Keep new backend modules under `server/handlers`, `server/middlewares`,
`server/config`, `server/services`, `server/repositories`, `server/providers`, `server/tasks`,
`server/utils`, or `server/types`; connect routes through `server/endpoints.dowe`.

For a CRUD feature, keep the layers explicit: `server/handlers` parses request input and returns
HTTP responses, `server/services` coordinates the use case, `server/repositories` performs
Database operations, `server/entities` exports entity declarations, and `server/config` imports
those entities into the Database handle. A handler should not open a Database handle or contain a
`query` statement. For editor-friendly tabs, name generated modules with the responsibility suffix:
`blogs-handler.dowe`, `blogs-service.dowe`, `blogs-repository.dowe`, `blogs-entity.dowe`, and
`blogs-types.dowe`.

## Capability-first statement shape

Read server statements from left to right:

```text
<capability> <binding> <props>
<capability> <props>
```

Use the first form when the capability produces a named value, such as
`query blogs db:appDb.list table:"blogs"` or
`createBlogService result args:{ title:body.title }`. Use the second when the capability performs
an action without creating a value, such as `next context:{ auth:verified }`.

The binding is a new server-local name. Props are named `name:value` inputs. An imported function
name is the capability at its call site. Control capabilities can select a target instead of
creating a binding, for example `go refreshIndex args:{ force:true }`; the target is not a result
binding. Server source never uses assignment syntax.

Standard-library operations use
`<namespace> <binding> source:"<function>" <props>`, such as
`str authorization source:"join" values:["Bearer", session.id] delimiter:" "`.
Handlers and middleware use `return status:201 json:result`; reusable `fn` declarations use
`return value:<value>`.

## Native TLS

Put `tls` directly inside the main server. ACME mode issues and renews a multi-domain Let's Encrypt
certificate in the Rust runtime and caches it below `.dowe`; local mode creates a self-signed
certificate for loopback development.

```text
main
  server port:443
    tls:
      mode:"acme"
      domains:["example.com", "www.example.com"]
      email:"admin@example.com"
      staging:false
```

`staging` defaults to `true`. ACME domains must be public DNS names and cannot be wildcard, IP, or
localhost values. For local HTTPS use `mode:"local"` with `localhost` or a `.localhost` subdomain.
Large catalogs are served through SNI and deterministic certificate groups of at most 100 names.

An authored domain manager may add local KV domains with
`domainsFrom:{ kv:"domains" key:"tls" }` or Database records with
`domainsFrom:{ db:"control" table:"domains" field:"hostname" }`. `refreshSeconds` defaults to 60
and must be between 30 and 86400. Keep TLS caches, account state, and private keys server-only.

```text
import createBlogService from "@/server/services/blogs-service"

handler createBlog
  const body value:req.json
  createBlogService result args:{ title:body.title content:body.content }
  return status:201 json:result
```

Imported functions start their call statement and bind the result in the next position. Standard
library namespaces follow the same shape, such as
`str title source:"trim" value:body.title`. Do not write `let result = createBlogService` or any
other server assignment.

Request metadata also declares its binding without an assignment:

```text
request query source:"query"
request range source:"header" name:"Range"
request sessionCookie source:"cookie" name:"session"
```

Use `ws event source:"json"` inside a WebSocket message handler and
`agent chat source:"chat" request:event` for the server-owned Agent transformation.

## General function utilities

| Utility | Binding | Required props | Optional props and limits |
| --- | --- | --- | --- |
| `function result` | `result` | Imported function name | `args:{...}` when params exist |
| `namespace result source:"function"` | `result` | `source` and function-specific named props | Portable standard library; `id result source:"ulid"` is server-only |
| `spawn process` | `process` | `command:string` | `args:string[]`, `cwd:string`, `timeoutMs:number`, `maxOutputBytes:number`, `background:boolean` |
| `http upstream` | `upstream` | `method:string`, `base:string or env`, `path:string` | `bearer`, `headers`, `json`, `mode:"json|proxy|bytes"`, `redirect`, `maxRedirects`, `timeoutMs` |
| `crypto output` | `output` | `encryption:"aesCtr|cencAesCtr"`, `data`, `key`, `iv` | `subsamples:[{ clear:number encrypted:number }]` |
| `go function` | none | Imported function name | `args:{...}`; fire-and-forget from server actions or functions |
| `cron function` | none | Imported function name, `schedule:string` | `args:{...}`; valid only directly under `server.init` or `desktop.server.init` |

```text
spawn ffmpeg command:"ffmpeg" args:["-version"] timeoutMs:5000 maxOutputBytes:65536
http upstream method:"get" base:env.MEDIA_BASE_URL path:"/segment.m4s" mode:"bytes"
crypto encrypted encryption:"cencAesCtr" data:upstream key:env.MEDIA_KEY iv:env.MEDIA_IV
```

`ffmpeg`, `upstream`, and `encrypted` are result bindings. `spawn`, `http`, and `crypto` are the
utilities that create them. A later utility reads a previous binding through a prop such as
`data:upstream`.

`go` and `cron` target a function but do not create result bindings. `go` discards the function
result. `cron` registers a UTC five-field schedule during server initialization.

## Endpoint routing

```text
import { listBlogs, createBlog } from "@/server/handlers/blogs-handler"
import requireBearer from "@/server/middlewares/auth"

endpoints apiRoutes
  group path:"/api/blogs"
    get path:"" handler:listBlogs
    post path:"" handler:createBlog middleware:[requireBearer]
```

Endpoint groups are one level: a `group path:<string> middleware:[...]` contains direct lowercase
`get`, `post`, `put`, `patch`, and `delete` utilities, plus WebSockets. HTTP methods and WebSockets
also accept optional `middleware`. Do not nest `group` nodes. WebSockets use
`websocket path:"..." middleware:[...]` and lifecycle children.

### Opaque Bearer sessions

Bearer identifies the HTTP authorization transport; it does not require JWT. When the application
already has Database and Cache, prefer an opaque ULID session for immediate revocation and explicit
per-device state. Generate it with `id session source:"ulid"`, persist the session record, and cache a
minimal server-owned projection under a namespaced key such as `session:<ulid>`.

```text
import { appDb, appCache } from "@/server/config/database"

middleware requireBearer
  bearer token value:req.header.Authorization
  session verified cache:appCache database:appDb token:token maxAge:2592000
  if verified.valid
    next context:{ auth:{ subject:verified.userId session:verified.id token:token } }
  return status:401 json:{ ok:false error:"Unauthorized" }
```

`session verified ...` declares the verification result, checks the ULID age, reads Cache first,
falls back to `sessions` in Database, and rehydrates Cache on a valid miss. Do not write
`let verified = session.verify ...`; host capabilities bind their result directly. Delete both the
Cache key and Database record on logout or ban. Keep JWT for stateless signed assertions or
interoperability with services that cannot share a session store; do not put sensitive claims in an
opaque token or trust client-provided Cache values.

## Database, Cache, and Vector utilities

### Handles

| Utility | Binding | Props |
| --- | --- | --- |
| `database appDb` | Database connection | Required static `provider`; provider-specific `host`, `port`, `account`, `secret`, and `name`; optional imported `entities` and `seeders` |
| `cache appCache` | Cache connection | Required `provider`, `host`, `port`, `account`, `secret`, and `name` |
| `vector appVector` | Vector connection | Required `provider:"dowe"`, `host`, `port`, `account`, `secret`, and `name` |

Database providers are `postgres`, `d1`, and `dowe`. Postgres and Dowe require `host`, `port`,
`account`, `secret`, and `name`; D1 requires `account`, `secret`, and `name`. Connection values may
be static or server environment references; `provider` must be static. `entities` and `seeders`
contain imported or local bindings.

Cache providers are `kv` for Cloudflare KV, `redis` for Redis, and `dowe` for Dowe Cache. Vector
initially supports only `dowe`. Connection values may be static or server environment references;
`provider` must be static. Config modules may export `database`, `cache`, and `vector` bindings.
Import those bindings into repository
functions instead of opening the same handle repeatedly.

### Database queries

Every Database operation uses `query <binding> db:<handle>.<operation>`.

| Operation | Props |
| --- | --- |
| `list` | `table`; optional `where` |
| `read` | `table`; optional `where`, `required` |
| `insert` | `table`, `value` |
| `update` | `table`, `where`, `value`; optional `required` |
| `delete` | `table`, `where`; optional `required` |
| `query` | `sql`; optional scalar `params` for D1 prepared statements |
| `tx` | Indented query children followed by `commit` or `rollback` |

```text
import appDb from "@/server/config/database"

fn createBlogRepository params:{ title:string content:string }
  query created db:appDb.insert table:"blogs" value:{ title:args.title content:args.content }
  return value:created
```

Entity declarations can live in separate modules and be imported by the config module:

```text
import Blog from "@/server/entities/blog-entity"

database appDb provider:"dowe" host:env.DATABASE_HOST port:env.DATABASE_PORT account:env.DATABASE_ACCOUNT secret:env.DATABASE_SECRET name:env.DATABASE_NAME entities:[Blog] seeders:[]
```

Use Cloudflare's account and Database identifiers for D1. The operations remain `db:` operations
and the runtime binds values as prepared-statement parameters:

```text
database appDb provider:"d1" account:env.ACCOUNT_ID secret:env.CLOUDFLARE_API_TOKEN name:env.DATABASE_ID entities:[Blog] seeders:[Bootstrap]
```

D1 supports compound equality filters but not `db:<handle>.tx`. Keep account, token, and Database ID
in server-only environment variables. During `dowe dev`, Dowe uses its embedded persistent Database
for every provider and resolves only `name`; it does not start Wrangler or contact the authored
provider. `dowe deploy` generates SQL migration artifacts for Postgres and D1. Production applies
pending migrations and seeders before the server starts listening.

Bind request values separately from SQL when a D1 query needs custom filtering or pagination:

```text
query rows db:appDb.query sql:"SELECT id, name FROM icons WHERE category = ?1 LIMIT 60 OFFSET ((CAST(?2 AS INTEGER) - 1) * 60)" params:[req.params.category, req.params.page]
```

Do not interpolate a request reference into `sql`. The runtime binds query parameters using the
selected provider's native placeholder rules.

### Cache KV operations

Every Cache operation uses `kv <binding> conn:<connection>.<operation>`. Do not use Database
`query` for Cache.

| Operation | Props |
| --- | --- |
| `get` | `key`; optional `required` |
| `set` | `key`, `value` |
| `delete` | `key` |
| `keys` | optional `prefix` |
| `clear` | no operation props |

`key` accepts a quoted literal or a server reference that resolves to text. Runtime validation rejects
empty keys, path separators, control characters, `.` and `..`.

```text
import appCache from "@/server/config/data"

fn rememberBlog params:{ blog:unknown }
  kv saved conn:appCache.set key:"blogs:last-created" value:args.blog
  return value:saved
```

Session repositories can therefore build a namespaced key without interpolating raw request data:

```text
fn createSessionRepository params:{ userId:string }
  id session source:"ulid"
  str sessionKey source:"join" values:["session", session] delimiter:":"
  kv cached conn:appCache.set key:sessionKey value:{ id:session userId:args.userId }
  return value:{ id:session userId:args.userId }
```

During `dowe dev`, every provider uses persistent local data under `.dowe/kv/<name>`. Only `name`
is resolved; Dowe does not validate the effective remote credentials, start Wrangler, or connect to
the authored provider. Production resolves the full connection.

### Vector embedding operations

Every Vector operation uses `emb <binding> conn:<connection>.<operation>`.

| Operation | Props |
| --- | --- |
| `upsert` | `id`, `vector`; optional `metadata` |
| `search` | `vector`; optional `limit`, `minScore`, `where` |
| `read` | `id`; optional `required` |
| `delete` | `id` |
| `list` | optional `limit`, `where` |

```text
import appVector from "@/server/config/data"

fn findRelated params:{ vector:unknown }
  emb matches conn:appVector.search vector:args.vector limit:10 minScore:0.7
  return value:matches
```

Development resolves only `name` and stores data under `.dowe/vector/<name>`. In production,
`host:"local"` keeps the embedded engine; any other host uses Dowe Vector over an authenticated
persistent WebSocket.

Connections and operation results stay server-only. Return serializable values, never connections, secrets,
complete provider URLs, authorization headers, encryption keys, or process metadata that the client
does not need.
