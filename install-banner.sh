#!/bin/bash
# ============================================
# Custom ASCII art MOTD banner for Ubuntu
# ============================================
BANNER_FILE="/etc/update-motd.d/05-banner"
UPDATES_FILE="/etc/update-motd.d/90-updates-custom"

# --- Wylaczenie niechcianych komunikatow Ubuntu ---
for f in 10-help-text 50-motd-news 91-contract-ua-esm-status 90-updates-available; do
    if [ -f "/etc/update-motd.d/$f" ]; then
        chmod -x "/etc/update-motd.d/$f"
        echo "wylaczono: $f"
    fi
done

# --- Zapis pliku bannera ---
cat > "$BANNER_FILE" << 'EOF'
#!/bin/bash

# Kolory - odkomentuj jeden:
# COLOR="\e[95m"  # rozowy
# COLOR="\e[93m"  # zolty
# COLOR="\e[92m"  # zielony
# COLOR="\e[96m"  # cyjan
# COLOR="\e[91m"  # czerwony
# COLOR="\e[94m"  # niebieski
COLOR="\e[97m"    # bialy

# Gnerator grafik:
# https://patorjk.com/software/taag/#p=display&f=Puffy&t=BB-Studio&x=none&v=3&h=4&w=80&we=false
#
echo -e "$COLOR"
cat << 'BANNER'
 ___    ___            ___    _               _
(  _`\ (  _`\         (  _`\ ( )_            ( ) _
| (_) )| (_) ) ______ | (_(_)| ,_) _   _    _| |(_)   _
|  _ <'|  _ <'(______)`\__ \ | |  ( ) ( ) /'_` || | /'_`\
| (_) )| (_) )        ( )_) || |_ | (_) |( (_| || |( (_) )
(____/'(____/'        `\____)`\__)`\___/'`\__,_)(_)`\___/'
BANNER
echo -e "\e[0m"
EOF

chmod +x "$BANNER_FILE"
echo "zapisano banner: $BANNER_FILE"

# --- Tworzenie skryptu aktualizacji ---
if [ ! -f "$UPDATES_FILE" ]; then
    cat > "$UPDATES_FILE" << 'EOF'
#!/bin/bash
updates=$(/usr/lib/update-notifier/apt-check 2>&1 | cut -d';' -f1)
security=$(/usr/lib/update-notifier/apt-check 2>&1 | cut -d';' -f2)

echo "--------------------------------------------------------------------------------"
echo "$updates updates can be applied immediately."
if [ "$security" -gt 0 ] 2>/dev/null; then
    echo "$security of these updates are standard security updates."
fi
echo "--------------------------------------------------------------------------------"
EOF
    chmod +x "$UPDATES_FILE"
    echo "utworzono: $UPDATES_FILE"
else
    echo "plik aktualizacji juz istnieje, pomijam"
fi

echo ""
echo "=== Gotowe! Sprawdz efekt: run-parts /etc/update-motd.d/ ==="
echo ""
