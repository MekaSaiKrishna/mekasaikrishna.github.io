---
title: "Interactive Computational Tool"
date: 2026-02-04
categories: [Research, Tools]
tags: [Python, Simulation]
---
Adjust the slider below to see the real-time update.

<link rel="stylesheet" href="https://pyscript.net/releases/2024.1.1/core.css">
<script type="module" src="https://pyscript.net/releases/2024.1.1/core.js"></script>

<div style="background: #f8f9fa; padding: 20px; border: 1px solid #ddd; border-radius: 8px;">
    <label for="param">Frequency Parameter: </label>
    <input type="range" id="param" min="1" max="20" value="5" step="0.5" style="width: 100%;">
    <p>Value: <span id="param-val">5.0</span></p>
</div>

<div id="plot-target"></div>

<py-config>
    packages = ["matplotlib", "numpy"]
</py-config>

<script type="py" src="/_posts/interactive_plot.py"></script>
