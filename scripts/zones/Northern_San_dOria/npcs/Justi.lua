-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Justi
-- Conquest depending furniture seller
-----------------------------------
local ID = zones[xi.zone.NORTHERN_SAN_DORIA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local stock =
    {
        32, 170726, 1,    -- Dresser
        55,  69888, 1,    -- Cabinet
        59,  57333, 1,    -- Chiffonier
        49,  35272, 2,    -- Coffer
        1657,   92, 3,    -- Bundling Twine
        93,    518, 3,    -- Water Cask
        57,  15881, 3,    -- Cupboard
        24, 129168, 3,    -- Oak Table
        46,   8376, 3,    -- Armor Box
    }

    player:showText(npc, ID.text.JUSTI_SHOP_DIALOG)
    xi.shop.nation(player, stock, xi.nation.SANDORIA)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
