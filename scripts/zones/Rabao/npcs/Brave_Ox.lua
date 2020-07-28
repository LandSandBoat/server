-----------------------------------
-- Area: Rabao
--  NPC: Brave Ox
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Rabao/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        4654,  77350,    -- Protect IV
        4736,  73710,    -- Protectra IV
        4868,  63700,    -- Dispel
        4860,  31850,    -- Stun
        4720,  31850,    -- Flash
        4750, 546000,    -- Reraise III
        4638,  78260,    -- Banish III
        4701,  20092,    -- Cura
        5082,  88389,    -- Cura II
        4702,  62192,    -- Sacrifice
        4703,  64584,    -- Esuna
        4704,  30967,    -- Auspice
        4614, 141137,    -- Cure VI
        4655, 103882,    -- Protect V
        4660, 125069,    -- Shell V
        5103, 140332,    -- Crusade
    }

    player:showText(npc, ID.text.BRAVEOX_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
