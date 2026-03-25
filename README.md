<p align="center">
	<img src="https://capsule-render.vercel.app/api?type=waving&height=180&color=0:0F4C81,100:1B98E0&text=SmartWatt&fontColor=FFFFFF&fontSize=44&desc=Hybrid%20AI%20and%20Physics%20for%20Residential%20Energy%20Estimation&descSize=14&descAlignY=68" alt="SmartWatt banner" />
</p>

<p align="center">
	<img src="https://img.shields.io/badge/Status-Beta-0F4C81" alt="Status" />
	<img src="https://img.shields.io/badge/Backend-FastAPI-009688" alt="Backend" />
	<img src="https://img.shields.io/badge/Frontend-Next.js-111111" alt="Frontend" />
	<img src="https://img.shields.io/badge/ML-TensorFlow-FF6F00" alt="ML" />
	<img src="https://img.shields.io/badge/License-MIT-2E7D32" alt="License" />
</p>

# SmartWatt

SmartWatt is a full-stack residential energy estimation platform for Kerala households. The project combines a machine learning inference layer with physics-based constraints to produce appliance-level consumption estimates, bill projections, and usage insights.

## About

SmartWatt is designed to provide practical, software-only household energy intelligence without requiring additional IoT hardware. The platform estimates appliance-wise consumption from user-provided inputs, reconciles predictions with physics constraints, and produces transparent reports aligned with Kerala tariff structures. It is intended for student research, engineering validation, and real-world decision support for electricity cost optimization.

## Product Preview

| Application Home | User Workflow |
|---|---|
| <img src="docs/screenshots/smartwatt-home.png" alt="SmartWatt home" width="100%" /> | <img src="docs/screenshots/smartwatt-workflow.png" alt="SmartWatt workflow" width="100%" /> |

| Dashboard | Results Report |
|---|---|
| <img src="docs/screenshots/smartwatt-dashboard.png" alt="SmartWatt dashboard" width="100%" /> | <img src="docs/screenshots/smartwatt-results.png" alt="SmartWatt results" width="100%" /> |

If images are not visible yet, add files to `docs/screenshots/` as described in `docs/screenshots/README.md`.

## Repository Structure

- `Backend/`: FastAPI-based inference and billing service.
- `Frontend/`: Next.js-based web application and dashboard.
- `start_backend.bat`: convenience launcher for backend development.
- `Run.txt`: minimal local run reference.

## Key Features

- Hybrid AI and deterministic physics pipeline.
- Appliance-level and batch prediction endpoints.
- KSEB slab-aware bill calculation.
- Scenario simulation for potential savings.
- Dashboard reporting and persisted assessment history.

## System Highlights

<details>
<summary><strong>Hybrid Inference Pipeline</strong></summary>

- Routes complex appliances through trained neural models.
- Uses deterministic physics constraints for stable outputs.
- Provides confidence and anomaly metadata for transparency.

</details>

<details>
<summary><strong>End-to-End User Flow</strong></summary>

- Guided multi-step input on the frontend.
- Batch prediction and reconciliation in backend services.
- KSEB tariff-aware billing and optimization insights.

</details>

## Quick Start

1. Start backend:

```bash
cd Backend
python -m uvicorn main:app --reload --port 8000
```

2. Start frontend in a second terminal:

```bash
cd Frontend
npm install
npm run dev
```

3. Open the application:

- Frontend: http://localhost:3000
- Backend API: http://localhost:8000
- Backend docs: http://localhost:8000/docs

## Configuration

- Keep local secrets only in `.env` or `.env.local` files.
- Use `.env.example` files as templates for required keys.

## Development Standards

- TypeScript and Python code should remain lint- and test-friendly.
- API schema and frontend field mappings should be updated together.
- Documentation changes should accompany architectural or interface changes.

## License

This repository is licensed under the MIT License. See `LICENSE`.
