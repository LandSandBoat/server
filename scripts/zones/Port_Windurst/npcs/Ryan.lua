-----------------------------------
-- Area: Port Windurst
--  NPC: Ryan
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        16640,  290,    -- Bronze Axe
        16535,  246,    -- Bronze Sword
        17336,    5,    -- Crossbow Bolt
        12576,  235,    -- Bronze Harness
        12577, 2286,    -- Brass Harness
        12704,  128,    -- Bronze Mittens
        12705, 1255,    -- Brass Mittens
        12832,  191,    -- Bronze Subligar
        12833, 1840,    -- Brass Subligar
        12960,  117,    -- Bronze Leggings
        12961, 1140,    -- Brass Leggings
        12584, 1145,    -- Kenpogi
        12712,  630,    -- Tekko
        12840,  915,    -- Sitabaki
        12968,  584,    -- Kyahan
    }

    player:showText(npc, ID.text.RYAN_SHOP_DIALOG)
    xi.shop.general(player, stock, xi.fameArea.WINDURST)
end

return entity
