-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: ???
-- !pos -318.752 -1.075 -488.509 50
-----------------------------------
require("scripts/globals/keyitems")
require("scripts/globals/shop")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    local mapID = 1473 -- Replace this with the actual map item ID you want to provide
    if not player:hasItem(mapID) then
        player:addItem(mapID)
        player:messageSpecial("You obtain the %s.", player:getItemName(mapID))
    else
        player:messageSpecial("You already possess this map.")
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity