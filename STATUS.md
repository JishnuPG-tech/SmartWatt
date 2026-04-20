# SmartWatt System Health Status
> Automatically updated every 3 hours

**Last Checked:** Mon Apr 20 11:01:29 UTC 2026 UTC

## 🟢 Backend (Python/FastAPI)
```text
============================= test session starts ==============================
platform linux -- Python 3.10.20, pytest-9.0.3, pluggy-1.6.0
rootdir: /home/runner/work/SmartWatt/SmartWatt/Backend
plugins: anyio-4.13.0
collected 23 items / 2 errors

==================================== ERRORS ====================================
________________ ERROR collecting tests/integration/test_api.py ________________
tests/integration/test_api.py:9: in <module>
    from main import app
main.py:13: in <module>
    app = FastAPI(title="SmartWatt AI Backend", lifespan=lifespan)
E   NameError: name 'lifespan' is not defined
________________ ERROR collecting tests/unit/test_edge_cases.py ________________
tests/unit/test_edge_cases.py:10: in <module>
    from main import app
main.py:13: in <module>
    app = FastAPI(title="SmartWatt AI Backend", lifespan=lifespan)
E   NameError: name 'lifespan' is not defined
=========================== short test summary info ============================
ERROR tests/integration/test_api.py - NameError: name 'lifespan' is not defined
ERROR tests/unit/test_edge_cases.py - NameError: name 'lifespan' is not defined
!!!!!!!!!!!!!!!!!!! Interrupted: 2 errors during collection !!!!!!!!!!!!!!!!!!!!
============================== 2 errors in 8.03s ===============================
⚠️ Backend tests failed.
```

## 🟢 Frontend (Next.js)
```text

> frontend@0.1.0 build
> next build

⚠ No build cache found. Please configure build caching for faster rebuilds. Read more: https://nextjs.org/docs/messages/no-cache
Attention: Next.js now collects completely anonymous telemetry regarding usage.
This information is used to shape Next.js' roadmap and prioritize features.
You can learn more, including how to opt-out if you'd not like to participate in this anonymous program, by visiting the following URL:
https://nextjs.org/telemetry

   ▲ Next.js 16.0.10 (Turbopack)

   Creating an optimized production build ...
 ✓ Compiled successfully in 21.0s
   Running TypeScript ...
   Collecting page data using 3 workers ...
   Generating static pages using 3 workers (0/7) ...
🔌 API BASE URL: http://localhost:8000
   Generating static pages using 3 workers (1/7) 
   Generating static pages using 3 workers (3/7) 
   Generating static pages using 3 workers (5/7) 
 ✓ Generating static pages using 3 workers (7/7) in 604.2ms
   Finalizing page optimization ...

Route (app)
┌ ○ /
├ ○ /_not-found
├ ○ /dashboard
├ ○ /login
└ ○ /register


○  (Static)  prerendered as static content

```
