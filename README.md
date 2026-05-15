# Consommation énergétique & Affinité CPU

Recherche sur l'impact de l'affinité CPU sur la consommation énergétique
des serveurs web (Nginx & Node.js) sous Linux.

## Structure
- `experiments/` : scripts de benchmark et configuration
- `results/`     : données brutes des mesures
- `analysis/`    : notebooks Python et graphiques
- `docs/`        : mémoire complet

## Outils utilisés
taskset, perf stat, Powerstat/RAPL
