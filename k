    <!DOCTYPE html>
<html lang="tr">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <title>Basit Video Site - Açıldığında Video Oynat</title>
  <style>
    :root{--bg:#0f172a}
    html,body{height:100%;margin:0;font-family:Inter,system-ui,Segoe UI,Roboto,'Helvetica Neue',Arial}
    body{background:var(--bg);display:flex;align-items:center;justify-content:center;color:#fff}
    .wrap{width:min(1100px,95%);max-width:1100px}
    header{display:flex;align-items:center;justify-content:space-between;margin-bottom:14px}
    h1{font-size:18px;margin:0}
    .controls{display:flex;gap:8px;align-items:center}
    .player-card{background:rgba(255,255,255,0.04);padding:18px;border-radius:14px;box-shadow:0 6px 20px rgba(2,6,23,0.6)}
    video{width:100%;height:auto;border-radius:10px;display:block;background:#000}
    .small{font-size:13px;opacity:.9}
    .row{display:flex;gap:8px;align-items:center}
    input[type='text']{padding:8px;border-radius:8px;border:1px solid rgba(255,255,255,0.08);background:transparent;color:inherit;min-width:260px}
    button{padding:8px 12px;border-radius:8px;border:0;background:#2563eb;color:#fff;cursor:pointer}
    .ghost{background:transparent;border:1px solid rgba(255,255,255,0.08)}
    label{display:flex;gap:6px;align-items:center}
    .muted-toggle{display:flex;gap:6px;align-items:center}
    @media (max-width:520px){h1{font-size:16px}input[type='text']{min-width:120px}}
  </style>
</head>
<body>
  <div class="wrap">
    <header>
      <h1>Basit Video Site — Açıldığında Video Oynat</h1>
      <div class="controls">
        <label class="small">Arka plan: <input id="bgcolor" type="color" value="#0f172a" title="Arka plan rengini seç"/></label>
      </div>
    </header>

    <div class="player-card">
      <!-- Video element: site açıldığında oynatmak için autoplay ve muted kullanıyoruz (tarayıcıların autoplay politikaları gereği). -->
      <video id="mainVideo" controls autoplay muted playsinline>
        <source id="videoSource" src="Desktop 2025.10.13 - 18.54.18.01.mp4" type="video/mp4">
        Tarayıcınız video etiketini desteklemiyor.
      </video>

      <div style="display:flex;justify-content:space-between;align-items:center;margin-top:10px;gap:8px;flex-wrap:wrap">
        <div class="row">
          <input id="videoUrl" type="text" placeholder="Video URL'si yapıştırın veya bırakın (örn. https://...)" />
          <button id="loadUrl">URL ile Yükle</button>
          <input id="localFile" type="file" accept="video/*" style="display:none" />
          <button id="chooseFile" class="ghost">Bilgisayardan Seç</button>
        </div>

        <div class="row small">
          <label class="muted-toggle"><input id="autoplayMute" type="checkbox" checked /> Otomatik sessiz başlat</label>
          <button id="playNow">Hemen Oynat</button>
        </div>
      </div>

      <p class="small" style="margin-top:10px;opacity:0.8">Kullanım: <strong>video.mp4</strong> dosyasını aynı klasöre koyarak yerelden oynatabilir veya üstteki kutuya bir video URL'si yapıştırıp "URL ile Yükle" butonuna tıklayabilirsiniz. Otomatik oynatma tarayıcı ayarlarına bağlıdır; tarayıcılar izin vermiyorsa kullanıcı etkileşimi gerekebilir.</p>
    </div>
  </div>

  <script>
    const video = document.getElementById('mainVideo');
    const source = document.getElementById('videoSource');
    const urlInput = document.getElementById('videoUrl');
    const loadBtn = document.getElementById('loadUrl');
    const fileInput = document.getElementById('localFile');
    const chooseFileBtn = document.getElementById('chooseFile');
    const playBtn = document.getElementById('playNow');
    const muteCheckbox = document.getElementById('autoplayMute');
    const bgColorPicker = document.getElementById('bgcolor');

    // Arka plan rengini değiştir
    bgColorPicker.addEventListener('input', e => document.documentElement.style.setProperty('--bg', e.target.value));

    // URL ile yükle
    loadBtn.addEventListener('click', () => {
      const url = urlInput.value.trim();
      if(!url) return alert('Önce bir URL girin.');
      source.src = url;
      video.load();
      // Eğer otomatik sessizse mute ayarını uygula
      video.muted = muteCheckbox.checked;
      video.play().catch(()=>{/* bazı tarayıcılar autoplay kısıtlayabilir */});
    });

    // Yerel dosya seç
    chooseFileBtn.addEventListener('click', () => fileInput.click());
    fileInput.addEventListener('change', e => {
      const file = e.target.files[0];
      if(!file) return;
      const blobUrl = URL.createObjectURL(file);
      source.src = blobUrl;
      video.load();
      video.muted = muteCheckbox.checked;
      video.play().catch(()=>{});
    });

    // Hemen oynat butonu
    playBtn.addEventListener('click', () => {
      video.muted = muteCheckbox.checked;
      video.play().catch(err => console.log('Oynatma hatası:', err));
    });

    // Sayfa yüklendiğinde video.mp4 varsa dene
    window.addEventListener('load', () => {
      // video elementinde src varsa otomatik olarak yüklemeye çalış
      video.muted = muteCheckbox.checked;
      video.play().catch(()=>{});
    });
  </script>
</body>
</html>
