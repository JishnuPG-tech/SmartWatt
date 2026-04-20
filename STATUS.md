# SmartWatt System Health Status
> Automatically updated every 3 hours

**Last Checked:** Mon Apr 20 08:06:49 UTC 2026 UTC

## 🟢 Backend (Python/FastAPI)
```text
============================= test session starts ==============================
platform linux -- Python 3.10.20, pytest-9.0.3, pluggy-1.6.0
rootdir: /home/runner/work/SmartWatt/SmartWatt/Backend
plugins: anyio-4.13.0
collected 36 items

tests/e2e/test_ac_age_flow.py ...                                        [  8%]
tests/e2e/test_complete_flow.py .....                                    [ 22%]
tests/e2e/test_e2e_ac_age.py ..                                          [ 27%]
tests/integration/test_api.py .....                                      [ 41%]
tests/integration/test_backend_reception.py .                            [ 44%]
tests/unit/test_all_ranges.py .                                          [ 47%]
tests/unit/test_anomaly.py .                                             [ 50%]
tests/unit/test_dynamic_range.py ..                                      [ 55%]
tests/unit/test_edge_cases.py ........                                   [ 77%]
tests/unit/test_logic.py ......                                          [ 94%]
tests/validation/test_auto_train.py ..                                   [100%]

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

tests/e2e/test_complete_flow.py::test_field_mapping
  /opt/hostedtoolcache/Python/3.10.20/x64/lib/python3.10/site-packages/_pytest/python.py:170: PytestReturnNotNoneWarning: Test functions should return None, but tests/e2e/test_complete_flow.py::test_field_mapping returned <class 'bool'>.
  Did you mean to use `assert` instead of `return`?
  See https://docs.pytest.org/en/stable/how-to/assert.html#return-not-none for more information.
    warnings.warn(

tests/e2e/test_complete_flow.py::test_training_columns
  /opt/hostedtoolcache/Python/3.10.20/x64/lib/python3.10/site-packages/_pytest/python.py:170: PytestReturnNotNoneWarning: Test functions should return None, but tests/e2e/test_complete_flow.py::test_training_columns returned <class 'bool'>.
  Did you mean to use `assert` instead of `return`?
  See https://docs.pytest.org/en/stable/how-to/assert.html#return-not-none for more information.
    warnings.warn(

-- Docs: https://docs.pytest.org/en/stable/how-to/capture-warnings.html
======================= 36 passed, 4 warnings in 12.34s ========================
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
 ✓ Compiled successfully in 19.6s
   Running TypeScript ...
   Collecting page data using 3 workers ...
   Generating static pages using 3 workers (0/7) ...
🔌 API BASE URL: http://localhost:8000
   Generating static pages using 3 workers (1/7) 
   Generating static pages using 3 workers (3/7) 
   Generating static pages using 3 workers (5/7) 
 ✓ Generating static pages using 3 workers (7/7) in 514.4ms
   Finalizing page optimization ...

Route (app)
┌ ○ /
├ ○ /_not-found
├ ○ /dashboard
├ ○ /login
└ ○ /register


○  (Static)  prerendered as static content

```
