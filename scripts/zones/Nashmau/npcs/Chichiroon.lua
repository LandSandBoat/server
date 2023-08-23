-----------------------------------
-- Area: Nashmau
--  NPC: Chichiroon
-- Standard Merchant NPC
-----------------------------------
local ID = zones[xi.zone.NASHMAU]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
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
    xi.shop.general(player, stock)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
