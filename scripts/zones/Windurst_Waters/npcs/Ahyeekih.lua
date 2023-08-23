-----------------------------------
-- Area: Windurst Waters
--  NPC: Ahyeekih
-- Only sells when Windurst controls Kolshushu
-- Confirmed shop stock, August 2013
-----------------------------------
local ID = zones[xi.zone.WINDURST_WATERS]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.events.harvestFestival.onHalloweenTrade(player, trade, npc)
end

entity.onTrigger = function(player, npc)
    local regionOwner = GetRegionOwner(xi.region.KOLSHUSHU)

    if regionOwner ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.AHYEEKIH_CLOSED_DIALOG)
    else
        player:showText(npc, ID.text.AHYEEKIH_OPEN_DIALOG)

        local stock =
        {
            4503,   184,  -- Buburimu Grape
            1120,  1620,  -- Casablanca
            4359,   220,  -- Dhalmel Meat
            614,     72,  -- Mhaura Garlic
            4445,    40   -- Yagudo Cherry
        }
        xi.shop.general(player, stock, xi.quest.fame_area.WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
