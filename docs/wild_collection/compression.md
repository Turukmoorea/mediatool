# Komprimierungsbefehle für Dummy-Dateien

## Verzeichnisstruktur erstellen
```bash
mkdir -p rar/multipart 7z/multipart zip/multipart tar.xz/multipart tar.bz2/multipart tar.gz/multipart
```

## Singlepart-Archive für `dummy1G`

### RAR
```bash
rar a -r rar/dummy1G.rar dummy1G
```

### 7z
```bash
7z a 7z/dummy1G.7z dummy1G
```

### ZIP
```bash
zip zip/dummy1G.zip dummy1G
```

### tar.xz
```bash
tar -cJf tar.xz/dummy1G.tar.xz dummy1G
```

### tar.bz2
```bash
tar -cjf tar.bz2/dummy1G.tar.bz2 dummy1G
```

### tar.gz
```bash
tar -czf tar.gz/dummy1G.tar.gz dummy1G
```

---

## Multipart-Archive für `dummy3G` (Max. Part-Größe: 250 MB)

### RAR
```bash
rar a -v250M -r rar/multipart/dummy3G.rar dummy3G
```

### 7z
```bash
7z a -v250m 7z/multipart/dummy3G.7z dummy3G
```

### ZIP
```bash
zip -s 250m -r zip/multipart/dummy3G.zip dummy3G
```

### tar.xz
1. **Tar-Archiv erstellen:**
   ```bash
   tar -cf tar.xz/multipart/dummy3G.tar dummy3G
   ```
2. **Archiv splitten:**
   ```bash
   split -b 250M -d tar.xz/multipart/dummy3G.tar tar.xz/multipart/dummy3G.tar.part
   ```

### tar.bz2
1. **Tar-Archiv erstellen:**
   ```bash
   tar -cf tar.bz2/multipart/dummy3G.tar dummy3G
   ```
2. **Archiv komprimieren und splitten:**
   ```bash
   bzip2 -z tar.bz2/multipart/dummy3G.tar
   split -b 250M -d tar.bz2/multipart/dummy3G.tar.bz2 tar.bz2/multipart/dummy3G.tar.bz2.part
   ```

### tar.gz
1. **Tar-Archiv erstellen:**
   ```bash
   tar -cf tar.gz/multipart/dummy3G.tar dummy3G
   ```
2. **Archiv komprimieren und splitten:**
   ```bash
   gzip tar.gz/multipart/dummy3G.tar
   split -b 250M -d tar.gz/multipart/dummy3G.tar.gz tar.gz/multipart/dummy3G.tar.gz.part
   
