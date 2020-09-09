-----------------------------------
-- Area: Mhaura
--  NPC: Runito-Monito
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Mhaura/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        16405,  106,    -- Cat Bagnakhs
        16407, 1554,    -- Brass Bagnakhs
        16449,  855,    -- Brass Dagger
        17059,   92,    -- Bronze Rod
        17081,  634,    -- Brass Rod
        16531, 3601,    -- Brass Xiphos
        16583, 2502,    -- Claymore
        16704,  618,    -- Butterfly Axe
        17307,    9,    -- Dart
        17318,    3,    -- Wooden Arrow
        17319,    4,    -- Bone Arrow
        17336,    5,    -- Crossbow Bolts
    }

    player:showText(npc, ID.text.RUNITOMONITO_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
