# Proje Bağlamı

Bu repo, şirket UI projelerine karşılık gelen 3 ayrı React geliştirme ortamı içerir.
Kod burada yazılır, build alınır, çıktılar hem FTP'ye hem `build` branch'ine gönderilir.

## Proje Dizinleri

| Dizin | React | Temel Kütüphaneler | Karşılık |
|-------|-------|-------------------|---------|
| `food/` | 17 | Redux Toolkit, React Query v4, React Hook Form, Zod | Yemek projesi |
| `portal/` | 18 | React Router v6, React Query v3, ReactFlow, Lucide | Portal projesi |
| `news/` | 18 | React Query v5, React Router v7, D3 | Haber projesi |

## Branch Yapısı

- **`main`** → Kaynak kodlar buraya commit edilir
- **`build`** → Build çıktıları buraya gider (food/, portal/, news/, mgul/)

## Deploy Akışı

1. İlgili proje dizininde (`food/`, `portal/`, `news/`) bileşen/sayfa yaz
2. Deploy script'ini çalıştır — build alır, FTP'ye yükler:
   ```bash
   bash deploy.sh
   ```
3. Build branch'ini güncelle (gerektiğinde):
   ```bash
   # Proje distlerini + mgul distini build branch'e push eder
   ```

## FTP Bilgileri

`.ftp.env` dosyasında saklanır (gitignore'da, repoya gitmez).
Formatı için `deploy.sh` içindeki değişken isimlerine bakılır.

Deploy sonrası dosyalar şuraya gider:
- `gurcangul.com/ggul/food/`
- `gurcangul.com/ggul/portal/`
- `gurcangul.com/ggul/news/`

## Build Branch İçeriği

```
build/
├── food/    ← food/dist
├── portal/  ← portal/dist
├── news/    ← news/dist
└── mgul/    ← C:\Users\grcng\Desktop\time-line-gant\dist (ayrı proje)
```

`mgul/`'un kaynak kodu bu repoda **değil**, sadece dist dosyaları build branch'inde tutulur.

## Bileşen Geliştirme Kuralları

- Şirket proje isimlerini **hiçbir yere yazma**: title, h1, package name, commit mesajı
- Private şirket paketleri (`ykb-ui`, `ykb-react-scripts` vb.) bu repoda yok — public eşdeğerleriyle çalışılır
- Her projede `src/components/` altında bileşenler geliştirilir
- Deploy sonrası şirket PC'sinden `gurcangul.com/ggul/<proje>/` adresinden erişilir
