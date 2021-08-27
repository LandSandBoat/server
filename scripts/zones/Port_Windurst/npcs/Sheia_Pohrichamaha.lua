-----------------------------------
-- Area: Port Windurst
--  NPC: Sheia Pohrichamaha
-- Fauregandi Regional Merchant
-----------------------------------
local ID = require("scripts/zones/Port_Windurst/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.FAUREGANDI) ~= xi.nation.WINDURST then
        player:showText(npc, ID.text.SHEIAPOHRICHAMAHA_CLOSED_DIALOG)
    else
        local stock =
        {
            4571, 90,    -- Beaugreens
            4363, 39,    -- Faerie Apple
            691,  54,    -- Maple Log
        }

        player:showText(npc, ID.text.SHEIAPOHRICHAMAHA_OPEN_DIALOG)
        xi.shop.general(player, stock, WINDURST)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
