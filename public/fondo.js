const canvas = document.getElementById('xmb'), ctx = canvas.getContext('2d');
        function resize() { canvas.width = window.innerWidth; canvas.height = window.innerHeight }
        resize(); window.addEventListener('resize', resize);
        const ribbons = [
            { freqs: [1.2, 2.5, 0.4], amps: [1.0, 0.3, 0.15], phases: [0.0, 1.2, 2.5], speed: 0.000012, baseWidth: 0.08, alpha: 0.22, color: [140, 150, 160] },
            { freqs: [0.8, 1.8, 0.6], amps: [0.9, 0.4, 0.20], phases: [1.8, 0.5, 3.2], speed: 0.000009, baseWidth: 0.14, alpha: 0.18, color: [90, 100, 110] },
            { freqs: [1.5, 3.0, 0.5], amps: [0.7, 0.2, 0.25], phases: [3.5, 2.8, 0.1], speed: 0.000015, baseWidth: 0.05, alpha: 0.25, color: [160, 170, 180] },
            { freqs: [0.5, 1.2, 0.3], amps: [1.2, 0.5, 0.10], phases: [5.2, 3.7, 1.8], speed: 0.000006, baseWidth: 0.20, alpha: 0.12, color: [60, 65, 70] }
        ];
        const thinLines = [
            { sign: -1, dist: 0.15, freqs: [1.4, 2.8], amps: [1.0, 0.3], speed: 0.000010, alpha: 0.35 },
            { sign: 1, dist: 0.18, freqs: [1.1, 2.2], amps: [1.0, 0.4], speed: 0.000008, alpha: 0.25 }
        ];
        const particles = Array.from({ length: 60 }, () => ({ x: Math.random(), y: Math.random(), r: Math.random() * 1.2 + 0.3, speed: Math.random() * 0.000025 + 0.000008, phase: Math.random() * Math.PI * 2 }));
        function evalWave(nx, t, freqs, amps, phases) {
            let y = 0; for (let i = 0; i < freqs.length; i++)y += Math.sin(nx * Math.PI * freqs[i] + t + phases[i]) * amps[i];
            return y;
        }
        const STEP = 2;
        function draw(ts) {
            const W = canvas.width, H = canvas.height;
            ctx.globalCompositeOperation = 'source-over'; ctx.fillStyle = '#060709'; ctx.fillRect(0, 0, W, H);
            const bgGlow = ctx.createRadialGradient(W * 0.5, H * 0.5, 0, W * 0.5, H * 0.5, W * 0.7); bgGlow.addColorStop(0, 'rgba(45,55,65,0.4)'); bgGlow.addColorStop(1, 'rgba(6,7,9,0)');
            ctx.fillStyle = bgGlow; ctx.fillRect(0, 0, W, H);
            const nPts = Math.ceil(W / STEP) + 1;
            ribbons.forEach(r => {
                const t = ts * r.speed, [red, green, blue] = r.color;
                ctx.beginPath();
                for (let i = 0; i <= nPts; i++) {
                    const px = i * STEP, nx = px / W, cy = H * 0.5 + evalWave(nx, t, r.freqs, r.amps, r.phases) * H * 0.15;
                    i === 0 ? ctx.moveTo(px, cy - (r.baseWidth * H * 0.5)) : ctx.lineTo(px, cy - (r.baseWidth * H * 0.5));
                }
                for (let i = nPts; i >= 0; i--) {
                    const px = i * STEP, nx = px / W, cy = H * 0.5 + evalWave(nx, t, r.freqs, r.amps, r.phases) * H * 0.15;
                    ctx.lineTo(px, cy + (r.baseWidth * H * 0.5));
                }
                ctx.closePath(); ctx.globalCompositeOperation = 'lighter'; ctx.shadowBlur = 95; ctx.shadowColor = `rgba(${red},${green},${blue},${r.alpha * 1.5})`;
                ctx.fillStyle = `rgba(${red},${green},${blue},${r.alpha})`; ctx.fill();
                ctx.shadowBlur = 0; ctx.shadowColor = 'transparent'; ctx.beginPath();
                for (let i = 0; i <= nPts; i++) {
                    const px = i * STEP, nx = px / W, y = H * 0.5 + evalWave(nx, t, r.freqs, r.amps, r.phases) * H * 0.15 - (r.baseWidth * H * 0.5);
                    i === 0 ? ctx.moveTo(px, y) : ctx.lineTo(px, y);
                }
                ctx.strokeStyle = `rgba(255,255,255,${r.alpha * 3.0})`; ctx.lineWidth = 1.8; ctx.stroke();
                ctx.strokeStyle = `rgba(255,255,255,${r.alpha * 1.0})`; ctx.lineWidth = 0.5; ctx.stroke();
            });
            ctx.globalCompositeOperation = 'lighter';
            thinLines.forEach(line => {
                const t = ts * line.speed; ctx.beginPath();
                for (let i = 0; i < nPts; i++) {
                    const px = i * STEP, nx = px / W, y = H * 0.5 + line.sign * line.dist * H + evalWave(nx, t, line.freqs, line.amps, [0, 1.5]) * H * 0.05;
                    i === 0 ? ctx.moveTo(px, y) : ctx.lineTo(px, y);
                }
                ctx.strokeStyle = `rgba(220,230,240,${line.alpha})`; ctx.lineWidth = 0.7; ctx.stroke();
            });
            particles.forEach(p => {
                const moveY = Math.sin(p.phase + ts * p.speed) * 15; ctx.beginPath();
                ctx.arc(p.x * W, (p.y * H) + moveY, p.r, 0, Math.PI * 2);
                ctx.fillStyle = `rgba(230,240,255,${0.1 + 0.3 * Math.sin(p.phase + ts * 0.001)})`; ctx.fill();
            });
            requestAnimationFrame(draw);
        }
        requestAnimationFrame(draw);