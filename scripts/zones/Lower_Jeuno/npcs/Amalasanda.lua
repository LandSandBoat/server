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
        { xi.item.BAMBOO_STICK,               143 },
        { xi.item.SQUARE_OF_SILK_CLOTH,     21000 },
        { xi.item.PINCH_OF_BLACK_PEPPER,      255 },
        { xi.item.KOMA,                       220 },
        { xi.item.LUMP_OF_TAMA_HAGANE,       7000 },
        { xi.item.POT_OF_URUSHI,            73530 },
        { xi.item.UCHITAKE,                    40 },
        { xi.item.TSURARA,                     40 },
        { xi.item.KAWAHORI_OGI,                40 },
        { xi.item.MAKIBISHI,                   40 },
        { xi.item.HIRAISHIN,                   40 },
        { xi.item.MIZU_DEPPO,                  40 },
        { xi.item.SHIHEI,                     124 },
        { xi.item.JUSATSU,                    124 },
        { xi.item.KAGINAWA,                   124 },
        { xi.item.SAIRUI_RAN,                 124 },
        { xi.item.KODOKU,                     124 },
        { xi.item.SHINOBI_TABI,               124 },
        { xi.item.BOX_OF_STICKY_RICE,         316 },
        { xi.item.ONZ_OF_TURMERIC,            645 },
        { xi.item.ONZ_OF_CORIANDER,          1585 },
        { xi.item.SPRIG_OF_HOLY_BASIL,        800 },
        { xi.item.ONZ_OF_CURRY_POWDER,        990 },
        { xi.item.JAR_OF_GROUND_WASABI,      2595 },
        { xi.item.BOTTLE_OF_RICE_VINEGAR,     200 },
        { xi.item.BUNDLE_OF_SHIRATAKI,        492 },
        { xi.item.BAG_OF_BUCKWHEAT_FLOUR,    5000 },
        { xi.item.SCROLL_OF_KATON_ICHI,      2331 },
        { xi.item.SCROLL_OF_HYOTON_ICHI,     2331 },
        { xi.item.SCROLL_OF_HUTON_ICHI,      2331 },
        { xi.item.SCROLL_OF_DOTON_ICHI,      2331 },
        { xi.item.SCROLL_OF_RAITON_ICHI,     2331 },
        { xi.item.SCROLL_OF_SUITON_ICHI,     2331 },
        { xi.item.SCROLL_OF_JUBAKU_ICHI,     2849 },
        { xi.item.SCROLL_OF_HOJO_ICHI,       2849 },
        { xi.item.SCROLL_OF_KURAYAMI_ICHI,   2849 },
        { xi.item.SCROLL_OF_DOKUMORI_ICHI,   2849 },
        { xi.item.SCROLL_OF_TONKO_ICHI,      2849 },
        { xi.item.SCROLL_OF_MONOMI_ICHI,     9590 },
        { xi.item.SCROLL_OF_RECALL_JUGNER,  60750 },
        { xi.item.SCROLL_OF_RECALL_PASHH,   60750 },
        { xi.item.SCROLL_OF_RECALL_MERIPH,  60750 },
        { xi.item.SCROLL_OF_TELEPORT_VAHZL, 34656 },
        { xi.item.SCROLL_OF_TELEPORT_YHOAT, 34656 },
        { xi.item.SCROLL_OF_TELEPORT_ALTEP, 34656 },
        { xi.item.SCROLL_OF_TELEPORT_HOLLA, 32176 },
        { xi.item.SCROLL_OF_TELEPORT_DEM,   32176 },
        { xi.item.SCROLL_OF_TELEPORT_MEA,   32176 },
        { xi.item.SCROLL_OF_DRAIN,          10428 },
        { xi.item.SCROLL_OF_ASPIR,          12850 },
        { xi.item.SCROLL_OF_BLAZE_SPIKES,   10428 },
        { xi.item.SCROLL_OF_WARP,           11953 },
        { xi.item.SCROLL_OF_WARP_II,        37200 },
        { xi.item.SCROLL_OF_RETRACE,        32320 },
        { xi.item.SCROLL_OF_SLEEPGA_II,     67818 },
        { xi.item.SCROLL_OF_UTSUSEMI_ICHI,  13133 },
        { xi.item.SCROLL_OF_MAGES_BALLAD,   11833 },
    }

    player:showText(npc, zones[xi.zone.LOWER_JEUNO].text.AMALASANDA_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
