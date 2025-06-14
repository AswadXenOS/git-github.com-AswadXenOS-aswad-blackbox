#!/data/data/com.termux/files/usr/bin/bash

🎯 SETUP PENUH ASWAD-BLACKBOX (Backend + Frontend + Bot + PM2 + Shortcut)

echo "🚀 Memulakan auto-setup penuh..."

1. Ke root home
cd ~

2. Pasang pakej asas

pkg update -y && pkg install -y nodejs git wget nano termux-api npm install -g pm2

3. Clone projek

rm -rf aswad-blackbox git clone https://github.com/AswadXenOS/aswad-blackbox.git cd aswad-blackbox

4. Setup backend

mkdir -p backend && cat > backend/index.js <<EOF const express = require('express'); const app = express(); const PORT = process.env.PORT || 3000; app.get('/', (req, res) => res.send('Aswad Blackbox Backend OK')); app.listen(PORT, () => console.log(Backend running on port ${PORT})); EOF cd backend && npm init -y && npm install express && cd ..

5. Setup frontend (Vite + React)

npm create vite@latest frontend -- --template react cd frontend && npm install && cd ..

6. Setup bot

mkdir -p bot && cat > bot/bot.js <<EOF console.log("Aswad GPT CLI Bot Started"); // Tambah logik GPT nanti di sini EOF cd bot && npm init -y && cd ..

7. Skrip auto-start semua komponen

cat > start-aswad-blackbox.sh <<'EOF' #!/data/data/com.termux/files/usr/bin/bash echo "🚀 Memulakan semua komponen Aswad Blackbox..." termux-wake-lock

cd ~/aswad-blackbox/backend && pm2 start index.js --name blackbox-backend --update-env || pm2 restart blackbox-backend cd ~/aswad-blackbox/frontend && pm2 start npm --name blackbox-frontend -- run dev || pm2 restart blackbox-frontend cd ~/aswad-blackbox/bot && pm2 start bot.js --name blackbox-bot --interpreter node --update-env || pm2 restart blackbox-bot

pm2 save echo "✅ Semua sistem berjalan!" EOF chmod +x start-aswad-blackbox.sh

8. Shortcut ke Home Screen

termux-create-shortcut -t "Start Aswad Blackbox" -c "~/aswad-blackbox/start-aswad-blackbox.sh"

9. Auto-resurrect bila buka Termux

if ! grep -Fxq 'pm2 resurrect >/dev/null 2>&1' ~/.bashrc; then echo 'pm2 resurrect >/dev/null 2>&1' >> ~/.bashrc fi

10. Auto-start sekarang

~/aswad-blackbox/start-aswad-blackbox.sh

Tamat

clear echo "🎉 Siap 100%! Aswad Blackbox aktif sepenuhnya." echo "📦 Backend: http://localhost:3000" echo "🌐 Frontend: http://localhost:5173 (default Vite port)" echo "🤖 Bot: CLI output PM2 blackbox-bot" echo "🔁 Shortcut dah ditambah ke Home Screen!"

