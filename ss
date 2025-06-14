<!DOCTYPE html>
<html lang="es">
<head>
  <meta charset="UTF-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Explosión de Amor</title>
  <style>
    body {
      margin: 0;
      background: black;
      overflow: hidden;
      cursor: pointer;
    }

    canvas {
      display: block;
      position: absolute;
      top: 0;
      left: 0;
    }

    .overlay {
      position: absolute;
      top: 0;
      left: 0;
      width: 100%;
      height: 100%;
      z-index: 2;
      display: flex;
      align-items: center;
      justify-content: center;
      pointer-events: none;
    }

    .center-message {
      font-family: 'Courier New', monospace;
      color: #00bfff; /* Azul */
      font-size: 3rem;
      text-align: center;
      opacity: 0.8;
    }
  </style>
</head>
<body>

<canvas id="canvas"></canvas>
<div class="overlay">
  <div class="center-message">TE AMO GERALDINE 💙</div>
</div>

<script>
  const canvas = document.getElementById('canvas');
  const ctx = canvas.getContext('2d');
  canvas.width = window.innerWidth;
  canvas.height = window.innerHeight;

  const text = "TE AMO 💙";
  const fontSize = 16;
  const columns = Math.floor(canvas.width / (fontSize * 4));
  const drops = new Array(columns).fill(1);

  ctx.font = fontSize + "px monospace";

  // Dibujo estilo Matrix
  function drawMatrix() {
    ctx.fillStyle = "rgba(0, 0, 0, 0.05)";
    ctx.fillRect(0, 0, canvas.width, canvas.height);

    ctx.fillStyle = "#00bfff"; // Azul
    for (let i = 0; i < drops.length; i++) {
      const x = i * fontSize * 4;
      const y = drops[i] * fontSize;
      ctx.fillText(text, x, y);

      if (y > canvas.height && Math.random() > 0.975) {
        drops[i] = 0;
      }

      drops[i]++;
    }
  }

  // Partículas "TE AMO" al hacer clic
  let particles = [];

  canvas.addEventListener('click', (e) => {
    for (let i = 0; i < 20; i++) {
      particles.push({
        x: e.clientX,
        y: e.clientY,
        vx: (Math.random() - 0.5) * 4,
        vy: (Math.random() - 0.5) * 4,
        alpha: 1,
        size: fontSize + Math.random() * 8
      });
    }
  });

  function drawParticles() {
    particles.forEach((p, index) => {
      ctx.globalAlpha = p.alpha;
      ctx.font = p.size + "px monospace";
      ctx.fillStyle = "#1e90ff"; // Azul más brillante
      ctx.fillText("TE AMO", p.x, p.y);
      p.x += p.vx;
      p.y += p.vy;
      p.alpha -= 0.01;
      if (p.alpha <= 0) {
        particles.splice(index, 1);
      }
    });
    ctx.globalAlpha = 1;
  }
