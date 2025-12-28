-----------------------------------
-- Area: Lower Jeuno
--  NPC: Amalasanda
-- Type: Tenshodo Merchant
-- !pos 28.149 2.899 -44.780 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if not player:hasKeyItem(xi.ki.TENSHODO_MEMBERS_CARD) then
        return -- Anti-Cheat.
    end

    local stock =
    {
        { xi.item.BAMBOO_STICK,               151 },
        { xi.item.SQUARE_OF_SILK_CLOTH,     22050 },
        { xi.item.PINCH_OF_BLACK_PEPPER,      267 },
        { xi.item.KOMA,                       231 },
        { xi.item.LUMP_OF_TAMA_HAGANE,       7350 },
        { xi.item.POT_OF_URUSHI,            77206 },
        { xi.item.UCHITAKE,                    42 },
        { xi.item.TSURARA,                     42 },
        { xi.item.KAWAHORI_OGI,                42 },
        { xi.item.MAKIBISHI,                   42 },
        { xi.item.HIRAISHIN,                   42 },
        { xi.item.MIZU_DEPPO,                  42 },
        { xi.item.SHIHEI,                     131 },
        { xi.item.JUSATSU,                    131 },
        { xi.item.KAGINAWA,                   131 },
        { xi.item.SAIRUI_RAN,                 131 },
        { xi.item.KODOKU,                     131 },
        { xi.item.SHINOBI_TABI,               131 },
        { xi.item.BOX_OF_STICKY_RICE,         331 },
        { xi.item.ONZ_OF_TURMERIC,            677 },
        { xi.item.ONZ_OF_CORIANDER,          1664 },
        { xi.item.SPRIG_OF_HOLY_BASIL,        840 },
        { xi.item.ONZ_OF_CURRY_POWDER,       1039 },
        { xi.item.JAR_OF_GROUND_WASABI,      2724 },
        { xi.item.BOTTLE_OF_RICE_VINEGAR,     210 },
        { xi.item.BUNDLE_OF_SHIRATAKI,        516 },
        { xi.item.BAG_OF_BUCKWHEAT_FLOUR,    5250 },
        { xi.item.SCROLL_OF_KATON_ICHI,      2447 },
        { xi.item.SCROLL_OF_HYOTON_ICHI,     2447 },
        { xi.item.SCROLL_OF_HUTON_ICHI,      2447 },
        { xi.item.SCROLL_OF_DOTON_ICHI,      2447 },
        { xi.item.SCROLL_OF_RAITON_ICHI,     2447 },
        { xi.item.SCROLL_OF_SUITON_ICHI,     2447 },
        { xi.item.SCROLL_OF_JUBAKU_ICHI,     2991 },
        { xi.item.SCROLL_OF_HOJO_ICHI,       2991 },
        { xi.item.SCROLL_OF_KURAYAMI_ICHI,   2991 },
        { xi.item.SCROLL_OF_DOKUMORI_ICHI,   2991 },
        { xi.item.SCROLL_OF_TONKO_ICHI,      2991 },
        { xi.item.SCROLL_OF_MONOMI_ICHI,    10069 },
        { xi.item.SCROLL_OF_RECALL_JUGNER,  63787 },
        { xi.item.SCROLL_OF_RECALL_PASHH,   63787 },
        { xi.item.SCROLL_OF_RECALL_MERIPH,  63787 },
        { xi.item.SCROLL_OF_TELEPORT_VAHZL, 36388 },
        { xi.item.SCROLL_OF_TELEPORT_YHOAT, 36388 },
        { xi.item.SCROLL_OF_TELEPORT_ALTEP, 36388 },
        { xi.item.SCROLL_OF_TELEPORT_HOLLA, 33784 },
        { xi.item.SCROLL_OF_TELEPORT_DEM,   33784 },
        { xi.item.SCROLL_OF_TELEPORT_MEA,   33784 },
        { xi.item.SCROLL_OF_DRAIN,          10949 },
        { xi.item.SCROLL_OF_ASPIR,          13492 },
        { xi.item.SCROLL_OF_BLAZE_SPIKES,   10949 },
        { xi.item.SCROLL_OF_WARP,           12550 },
        { xi.item.SCROLL_OF_WARP_II,        39060 },
        { xi.item.SCROLL_OF_RETRACE,        33936 },
        { xi.item.SCROLL_OF_SLEEPGA_II,     71208 },
        { xi.item.SCROLL_OF_UTSUSEMI_ICHI,  13789 },
        { xi.item.SCROLL_OF_MAGES_BALLAD,   12424 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.AMALASANDA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
