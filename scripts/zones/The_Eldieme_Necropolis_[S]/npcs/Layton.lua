-----------------------------------
-- Area: The Eldieme Necropolis (S)
--  NPC: Layton
-- Note: Available during Campaign battles
-- !pos 382.679 -39.999 3.541 175
-----------------------------------
local ID = zones[xi.zone.THE_ELDIEME_NECROPOLIS_S]
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    local stock =
    {
        6049,  8060,    -- Firestorm Schema
        6050,  6318,    -- Rainstorm Schema
        6051,  9100,    -- Thunderstorm Schema
        6052,  8580,    -- Hailstorm Schema
        6053,  5200,    -- Sandstorm Schema
        6054,  6786,    -- Windstorm Schema
        6055, 11440,    -- Aurorastorm Schema
        6056, 10725,    -- Voidstorm Schema
        6041,  7714,    -- Pyrohelix Schema
        6042,  6786,    -- Hydrohelix Schema
        6043,  8625,    -- Ionohelix Schema
        6044,  7896,    -- Cryohelix Schema
        6045,  6591,    -- Geohelix Schema
        6046,  6981,    -- Anemohelix Schema
        6047,  8940,    -- Luminohelix Schema
        6048,  8790,    -- Noctohelix Schema
    }

    player:showText(npc, ID.text.LAYTON_SHOP_DIALOG)
    xi.shop.general(player, stock)
end

return entity
