import time
import sys
from tkinter import Tk, Label, Button, Canvas, StringVar

def update_progress(progress, description):
    progress_var.set(f"{progress}%")
    description_var.set(description)
    canvas.coords(progress_bar, 0, 0, progress * 3, 30)
    root.update_idletasks()

def abort_installation():
    sys.exit("Instalación abortada por el usuario.")

root = Tk()
root.title("Instalador")
root.configure(bg="black")

Label(root, text="Instalador de env_collab", fg="green", bg="black", font=("Arial", 16)).pack(pady=10)
description_var = StringVar(value="Preparando instalación...")
Label(root, textvariable=description_var, fg="orange", bg="black", font=("Arial", 12)).pack(pady=5)

canvas = Canvas(root, width=300, height=30, bg="black", highlightthickness=0)
canvas.pack(pady=10)
progress_bar = canvas.create_rectangle(0, 0, 0, 30, fill="green")

progress_var = StringVar(value="0%")
Label(root, textvariable=progress_var, fg="green", bg="black", font=("Arial", 12)).pack(pady=5)

Button(root, text="Abortar", command=abort_installation, bg="red", fg="white").pack(pady=10)

# Simulación de progreso
for i in range(101):
    update_progress(i, f"Paso {i}/100: Ejecutando tarea...")
    time.sleep(0.05)

root.mainloop()
