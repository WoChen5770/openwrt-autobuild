#!/bin/sh
# shellcheck disable=SC2086,SC3043,SC2164,SC2103,SC2046,SC2155
source /etc/profile
BASE_PATH=$(cd $(dirname $0) && pwd)

# echo "src-git custom_golang https://github.com/openwrt/packages.git^golang-1.21" >> feeds.conf.default
# ./scripts/feeds update custom_golang

# rm -rf feeds/packages/net/adguardhome
rm -rf feeds/packages/net/mosdns
# rm -rf feeds/packages/net/msd_lite
# rm -rf feeds/packages/net/smartdns
rm -rf feeds/luci/themes/luci-theme-argon
# rm -rf feeds/luci/themes/luci-theme-netgear
rm -rf feeds/luci/applications/luci-app-adguardhome
rm -rf feeds/luci/applications/luci-app-mosdns
# rm -rf feeds/luci/applications/luci-app-netdata
# rm -rf feeds/luci/applications/luci-app-serverchan
rm -rf feeds/luci/applications/luci-app-openclash
rm -rf feeds/luci/applications/luci-app-passwall
rm -rf feeds/luci/applications/luci-app-argon-config
rm -rf feeds/luci/applications/luci-app-ssr-plus
rm -rf feeds/packages/net/trojan-plus
rm -rf feeds/packages/net/v2ray-geodata
rm -rf feeds/packages/net/v2ray-plugin
rm -rf feeds/packages/net/v2ray-core
rm -rf feeds/packages/net/shadowsocks-rust
rm -rf feeds/packages/net/xray-core
rm -rf feeds/packages/utils/v2dat

echo "更新golang版本为1.24"
rm -rf feeds/packages/lang/golang
git clone https://github.com/kenzok8/golang feeds/packages/lang/golang

# remove_unwanted_packages() {
#    local luci_packages=(
#        "luci-app-passwall" "luci-app-smartdns" "luci-app-ddns-go" "luci-app-rclone"
#        "luci-app-ssr-plus" "luci-app-vssr" "luci-theme-argon" "luci-app-daed" "luci-app-dae"
#        "luci-app-alist" "luci-app-argon-config" "luci-app-homeproxy" "luci-app-haproxy-tcp"
#        "luci-app-openclash" "luci-app-mihomo"
#    )
#    local packages_net=(
#        "haproxy" "xray-core" "xray-plugin" "dns2tcp" "dns2socks" "alist" "hysteria"
#        "smartdns" "mosdns" "adguardhome" "ddns-go" "naiveproxy" "shadowsocks-rust"
#        "sing-box" "v2ray-core" "v2ray-geodata" "v2ray-plugin" "tuic-client"
#        "chinadns-ng" "ipt2socks" "tcping" "trojan-plus" "simple-obfs"
#        "shadowsocksr-libev" "dae" "daed" "mihomo"
#    )
#    local small8_packages=(
#        "ppp" "firewall" "dae" "daed" "daed-next" "libnftnl" "nftables" "dnsmasq"
#    )
#
#    for pkg in "${luci_packages[@]}"; do
#        \rm -rf ./feeds/luci/applications/$pkg
#        \rm -rf ./feeds/luci/themes/$pkg
#    done

 #   for pkg in "${packages_net[@]}"; do
 #       \rm -rf ./feeds/packages/net/$pkg
 #   done

#   for pkg in "${small8_packages[@]}"; do
#        \rm -rf ./feeds/small8/$pkg
#    done

#    if [[ -d ./package/istore ]]; then
#        \rm -rf ./package/istore
#    fi
# }

# install_feeds() {
#    ./scripts/feeds update -i
#    for dir in ./feeds/*; do
#        # 检查是否为目录并且不以 .tmp 结尾，并且不是软链接
#        if [ -d "$dir" ] && [[ ! "$dir" == *.tmp ]] && [ ! -L "$dir" ]; then
#            if [[ $(basename "$dir") == "small8" ]]; then
#                install_small8
#            else
#                ./scripts/feeds install -f -ap $(basename "$dir")
#            fi
#        fi
#    done
# }

install_small8() {
    ./scripts/feeds install -p small8 -f  luci-app-passwall mosdns luci-app-mosdns \
    luci-app-openclash luci-app-poweroff luci-theme-argon luci-app-argon-config\
    luci-app-adguardhome luci-app-ssr-plus trojan-plus v2ray-geodata v2ray-plugin\
    v2ray-core shadowsocks-rust xray-core v2dat
}

# fix_miniupmpd() {
#     local PKG_HASH=$(awk -F"=" '/^PKG_HASH:/ {print $2}' ./feeds/packages/net/miniupnpd/Makefile)
#     if [[ $PKG_HASH == "fbdd5501039730f04a8420ea2f8f54b7df63f9f04cde2dc67fa7371e80477bbe" ]]; then
#         if [[ -f $BASE_PATH/patches/400-fix_nft_miniupnp.patch ]]; then
#             if [[ ! -d ./feeds/packages/net/miniupnpd/patches ]]; then
#                 mkdir -p ./feeds/packages/net/miniupnpd/patches
#             fi
#             \cp -f $BASE_PATH/patches/400-fix_nft_miniupnp.patch ./feeds/packages/net/miniupnpd/patches/
#         fi
#     fi
# }

# remove_unwanted_packages
install_small8
# fix_miniupmpd
