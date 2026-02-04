---
title: "Interactive Computational Tool"
date: 2026-02-04
categories: [Research, Tools]
tags: [Python, Simulation]
---

This interactive tool demonstrates a dynamic response analysis. Adjust the frequency parameter using the slider to see how the damped oscillation changes in real-time.

<link rel="stylesheet" href="https://pyscript.net/releases/2024.1.1/core.css">
<script type="module" src="https://pyscript.net/releases/2024.1.1/core.js"></script>

<div style="background: #f9f9f9; padding: 20px; border-radius: 10px; border: 1px solid #eee; margin-bottom: 20px;">
    <label for="param" style="font-weight: bold;">Frequency Parameter ($\omega$): </label>
    <input type="range" id="param" min="1" max="20" value="5" step="0.5" style="width: 100%; margin: 10px 0;">
    <p>Current Value: <span id="param-val" style="color: #d33; font-weight: bold;">5.0</span> rad/s</p>
</div>

<div id="plot-target" style="width: 100%; min-height: 400px; display: flex; align-items: center; justify-content: center; border: 1px dashed #ccc;">
    <p id="loading-msg">Initializing Python Environment... (may take 5-10 seconds)</p>
</div>

<py-config>
    packages = ["matplotlib", "numpy"]
</py-config>

<script type="py">
# Encapsulating code in a triple-quoted string prevents Jekyll from stripping line breaks
python_code = """
import matplotlib.pyplot as plt
import numpy as np
from pyscript import display, document
from pyodide.ffi import create_proxy

def compute_and_plot(event=None):
    # 1. Get the input value
    val_element = document.querySelector("#param")
    val = float(val_element.value)
    document.querySelector("#param-val").innerText = str(val)
    
    # 2. Computational Logic (Damped Harmonic Motion)
    t = np.linspace(0, 10, 500)
    # y = e^(-zeta*t) * cos(omega*t)
    y = np.exp(-0.1 * val * t) * np.cos(val * t)
    
    # 3. Create the Matplotlib figure
    fig, ax = plt.subplots(figsize=(8, 4), dpi=100)
    ax.plot(t, y, color='#2c3e50', lw=2, label=f'w = {val} rad/s')
    ax.set_title("Structural Dynamic Response", fontsize=14)
    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Amplitude")
    ax.set_ylim(-1.1, 1.1)
    ax.grid(True, linestyle='--', alpha=0.7)
    ax.legend()
    
    # 4. Clean up and Render
    target = document.querySelector("#plot-target")
    target.innerHTML = "" # Remove the loading message
    display(fig, target="plot-target")

# Link the HTML slider to the Python function
proxy = create_proxy(compute_and_plot)
document.querySelector("#param").addEventListener("input", proxy)

# Initial execution
compute_and_plot()
"""

# Execute the protected string
exec(python_code)
</script>

---

### How it works
This tool uses **PyScript** to run a Python environment directly in your browser via WebAssembly. 
* **NumPy** handles the vector calculations for the damped oscillation.
* **Matplotlib** renders the high-quality plot.
* No external server is required, making this a perfect fit for a GitHub Pages site.
