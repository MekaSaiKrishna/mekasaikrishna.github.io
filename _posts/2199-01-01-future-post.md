---
title: "Interactive Computational Tool"
date: 2026-02-04
categories: [Research, Tools]
tags: [Python, Simulation]
---

Below is an interactive demonstration using PyScript. You can adjust the parameters to see the plot update in real-time.

<link rel="stylesheet" href="https://pyscript.net/releases/2024.1.1/core.css">
<script type="module" src="https://pyscript.net/releases/2024.1.1/core.js"></script>

<div style="background: #f4f4f4; padding: 20px; border-radius: 10px; margin-bottom: 20px;">
    <label for="param">Input Parameter (e.g., Load or Frequency): </label>
    <input type="range" id="param" min="1" max="20" value="5" step="0.5" style="width: 100%;">
    <p>Current Value: <span id="param-val">5.0</span></p>
</div>

<div id="plot-target" style="width: 100%; min-height: 400px;"></div>

<py-config>
    packages = ["matplotlib", "numpy"]
</py-config>

<script type="py">
import matplotlib.pyplot as plt
import numpy as np
from pyscript import display, document
from pyodide.ffi import create_proxy

def compute_and_plot(event=None):
    # Get input from HTML
    val = float(document.querySelector("#param").value)
    document.querySelector("#param-val").innerText = str(val)
    
    # Example logic: A damped oscillation (relevant to structural mechanics)
    t = np.linspace(0, 10, 500)
    y = np.exp(-0.1 * val * t) * np.cos(val * t)
    
    fig, ax = plt.subplots(figsize=(8, 4))
    ax.plot(t, y, color='#2c3e50', lw=2)
    ax.set_title(f"Dynamic Response Analysis (ω = {val})")
    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Amplitude")
    ax.grid(True, linestyle='--')
    
    # Render to the target div
    target = document.querySelector("#plot-target")
    target.innerHTML = ""
    display(fig, target="plot-target")

# Link the slider to the Python function
proxy = create_proxy(compute_and_plot)
document.querySelector("#param").addEventListener("input", proxy)

# Initial render
compute_and_plot()
</script>
