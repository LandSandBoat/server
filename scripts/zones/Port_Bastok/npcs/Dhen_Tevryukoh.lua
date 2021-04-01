-----------------------------------
-- Area: Port Bastok
--  NPC: Dhen Tevryukoh
-- Elshimo Uplands Regional Merchant
-- !pos 35 -2 2 236
-----------------------------------
local ID = require("scripts/zones/Port_Bastok/IDs")
require("scripts/globals/conquest")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if GetRegionOwner(xi.region.ELSHIMOUPLANDS) ~= xi.nation.BASTOK then
        player:showText(npc, ID.text.DHENTEVRYUKOH_CLOSED_DIALOG)
    else
        local stock =
        {
            1413, 1656,    -- Cattleya
            628,   239,    -- Cinnamon
            4468,   73,    -- Pamamas
            721,   147,    -- Rattan Lumber
        }

        player:showText(npc, ID.text.DHENTEVRYUKOH_OPEN_DIALOG)
        xi.shop.general(player, stock, BASTOK)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
