# SmartWatt System Health Status
> Automatically updated every 3 hours

**Last Checked:** Mon Apr 20 05:34:00 UTC 2026 UTC

## 🟢 Backend (Python/FastAPI)
```text
============================= test session starts ==============================
platform linux -- Python 3.10.20, pytest-9.0.3, pluggy-1.6.0
rootdir: /home/runner/work/SmartWatt/SmartWatt/Backend
plugins: anyio-4.13.0
collected 34 items / 1 error

==================================== ERRORS ====================================
_____________ ERROR collecting tests/validation/test_auto_train.py _____________
ImportError while importing test module '/home/runner/work/SmartWatt/SmartWatt/Backend/tests/validation/test_auto_train.py'.
Hint: make sure your test modules/packages have valid Python names.
Traceback:
/opt/hostedtoolcache/Python/3.10.20/x64/lib/python3.10/importlib/__init__.py:126: in import_module
    return _bootstrap._gcd_import(name[level:], package, level)
tests/validation/test_auto_train.py:13: in <module>
    from train import train_appliance_model
train.py:10: in <module>
    import matplotlib.pyplot as plt
E   ModuleNotFoundError: No module named 'matplotlib'
=============================== warnings summary ===============================
main.py:30
  /home/runner/work/SmartWatt/SmartWatt/Backend/main.py:30: DeprecationWarning: 
          on_event is deprecated, use lifespan event handlers instead.
  
          Read more about it in the
          [FastAPI docs for Lifespan Events](https://fastapi.tiangolo.com/advanced/events/).
          
    @app.on_event("startup")

../../../../../../opt/hostedtoolcache/Python/3.10.20/x64/lib/python3.10/site-packages/fastapi/applications.py:4495
  /opt/hostedtoolcache/Python/3.10.20/x64/lib/python3.10/site-packages/fastapi/applications.py:4495: DeprecationWarning: 
          on_event is deprecated, use lifespan event handlers instead.
  
          Read more about it in the
          [FastAPI docs for Lifespan Events](https://fastapi.tiangolo.com/advanced/events/).
          
    return self.router.on_event(event_type)

-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html
=========================== short test summary info ============================
ERROR tests/validation/test_auto_train.py
!!!!!!!!!!!!!!!!!!!! Interrupted: 1 error during collection !!!!!!!!!!!!!!!!!!!!
========================= 2 warnings, 1 error in 6.97s =========================
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
 ✓ Compiled successfully in 21.7s
   Running TypeScript ...
   Collecting page data using 3 workers ...
   Generating static pages using 3 workers (0/7) ...
🔌 API BASE URL: http://localhost:8000
   Generating static pages using 3 workers (1/7) 
   Generating static pages using 3 workers (3/7) 
   Generating static pages using 3 workers (5/7) 
 ✓ Generating static pages using 3 workers (7/7) in 584.4ms
   Finalizing page optimization ...

Route (app)
┌ ○ /
├ ○ /_not-found
├ ○ /dashboard
├ ○ /login
└ ○ /register


○  (Static)  prerendered as static content

```
