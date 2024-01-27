-----------------------------------
-- Area: Sealion's Den
--  NPC: Airship_Door
-----------------------------------
local oneToBeFeared = require('scripts/zones/Sealions_Den/bcnms/one_to_be_feared_helper')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    oneToBeFeared.handleAirshipDoorTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    oneToBeFeared.handleOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    oneToBeFeared.handleOnEventFinish(player, csid, option, npc)
end

return entity
