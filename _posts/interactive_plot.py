import matplotlib.pyplot as plt
import numpy as np
from pyscript import display, document
from pyodide.ffi import create_proxy

def compute_and_plot(event=None):
    # Get input from HTML
    val_element = document.querySelector("#param")
    val = float(val_element.value)
    document.querySelector("#param-val").innerText = str(val)
    
    # Logic: Damped vibration/oscillation
    t = np.linspace(0, 10, 500)
    y = np.exp(-0.1 * val * t) * np.cos(val * t)
    
    fig, ax = plt.subplots(figsize=(8, 4))
    ax.plot(t, y, color='#2c3e50', lw=2)
    ax.set_title(f"Dynamic Response Analysis (w = {val})")
    ax.set_xlabel("Time (s)")
    ax.set_ylabel("Amplitude")
    ax.grid(True, linestyle='--')
    
    # Render to the target div
    target = document.querySelector("#plot-target")
    target.innerHTML = ""
    display(fig, target="plot-target")

# Create a proxy for the event listener
proxy = create_proxy(compute_and_plot)
document.querySelector("#param").addEventListener("input", proxy)

# Initial render
compute_and_plot()
