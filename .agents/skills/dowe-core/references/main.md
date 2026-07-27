# `main.dowe` and project structure

## Root files

| Path | Purpose |
| --- | --- |
| `main.dowe` | Required application entrypoint and target wiring |
| `theme.dowe` | Fonts, named color themes, and component visual defaults for views |
| `.env.example` | Shared environment names with empty values or non-secret placeholders |
| `.env` | Local effective values; never read, print, or commit this file |

`main.dowe` declares exactly one `main` block. It can own application metadata, one or more view
route graphs, a server, and an optional desktop server.

```text
import apiRoutes from "@/server/endpoints"
import everyDay from "@/server/tasks/every-day"
import viewRoutes from "@/views/views"

main
  app name:"Dowe Journal" bundle:"com.example.dowejournal"
  views:viewRoutes
  server port:8080
    endpoints:apiRoutes
    init
      cron everyDay schedule:"0 3 * * *" args:{}
```

### Main contracts

| Declaration | Accepted props or children |
| --- | --- |
| `app` | `name:string`, `bundle:reverse-DNS string` |
| `views:<binding>` | One imported `views` binding |
| `views:[...]` | Ordered non-empty imported `views` bindings |
| `server` | `port:number`, `endpoints:<binding or list>`; optional `cors`, `init`, inline routes, WebSockets, and protocol children |
| `desktop` | One nested `server` with the same server contract |

`theme.dowe` and `main.dowe` are Dowe configuration roots and cannot be imported. Dotenv files are
not Dowe Source Format and cannot be imported. All reusable modules use static imports and the `@/`
alias for the project root.

## Long declarations

Keep short declarations inline. When props make a line difficult to read, end the declaration header
with `:` and put one prop on each indented line. The header form cannot include inline props.

```text
store session:
  type:SessionState
  persistent:true
  value:{ authorization:"" token:"" user:{ id:"" name:"" email:"" } }
```

The same property-suite form works for other declarations that accept props. Props must appear before
structural children; multiline arrays and objects remain enclosed by `[]` or `{}`.

Declare every allowed name in `.env.example` or `.env` as `NAME=value`. The process environment
overrides `.env`; `.env.example` values are examples and never become effective values. Dowe source
uses static references such as `env.BACKEND_URL`. A name referenced from views becomes public client
configuration, while names used only by server remain private.

## Example tree

```text
server/
  config/
  handlers/
  middlewares/
  providers/
  services/
  repositories/
  tasks/
  utils/
  endpoints.dowe
types/
views/
  components/
  layouts/
  pages/
  store/
  views.dowe
main.dowe
theme.dowe
.env.example
.env
```

This tree is optional organization, not a compiler contract. Imports may connect equivalent
declarations from any project path. When using this structure, the folder responsibilities are:

- `server/config` exports reusable `db` and `kv` handle bindings.
- `server/handlers` owns HTTP request parsing and responses.
- `server/middlewares` owns authorization and request context.
- `server/providers` owns external provider calls.
- `server/services` coordinates business behavior.
- `server/repositories` owns Database and KV logic.
- `server/tasks` owns functions targeted by `go` or `cron`.
- `server/utils` owns small reusable server transformations.
- `server/endpoints.dowe` connects handlers and middleware to routes.
- `types` owns shared declared data shapes.
- `views/store` owns shared View Stores.
- `views/components` owns reusable view trees.
- `views/layouts` owns application shells.
- `views/pages` owns routed screens.
- `views/views.dowe` connects layouts and pages to route paths.

The responsibility names `services`, `repositories`, `providers`, `tasks`, and `utils` are optional
folders, not declaration keywords. Their files declare `fn <binding>` because `fn` is the only
reusable server function declaration. `main.dowe` and `theme.dowe` are the only Dowe files whose
root location is fixed; all other module surfaces are classified from declarations and imports.
