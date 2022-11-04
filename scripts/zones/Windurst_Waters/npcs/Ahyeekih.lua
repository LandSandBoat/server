-----------------------------------
-- Area: Windurst Waters
--  NPC: Ahyeekih
-- Only sells when Windurst controls Kolshushu
-- Confirmed shop stock, August 2013
-----------------------------------
require("scripts/globals/events/harvest_festivals")
local ID = require("scripts/zones/Windurst_Waters/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    onHalloweenTrade(player, trade, npc)
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

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
