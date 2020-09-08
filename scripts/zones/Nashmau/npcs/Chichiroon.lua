-----------------------------------
-- Area: Nashmau
--  NPC: Chichiroon
-- Standard Merchant NPC
-----------------------------------
local ID = require("scripts/zones/Nashmau/IDs")
require("scripts/globals/shop")

function onTrade(player, npc, trade)
end

function onTrigger(player, npc)
    local stock =
    {
        5497,  99224,    -- Bolter's Die
        5498,  85500,    -- Caster's Die
        5499,  97350,    -- Courser's Die
        5500, 100650,    -- Blitzer's Die
        5501, 109440,    -- Tactician's Die
        5502, 116568,    -- Allies' Die
        5503,  96250,    -- Miser's Die
        5504,  95800,    -- Companion's Die
        5505, 123744,    -- Avenger's Die
        6368,  69288,    -- Geomancer Die
        6369,  73920,    -- Rune Fencer Die
    }

    player:showText(npc, ID.text.CHICHIROON_SHOP_DIALOG)
    tpz.shop.general(player, stock)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
