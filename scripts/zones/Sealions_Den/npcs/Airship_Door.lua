-----------------------------------
-- Area: Sealion's Den
--  NPC: Airship_Door
-----------------------------------
local oneToBeFeared = require("scripts/zones/Sealions_Den/helpers/One_to_be_Feared")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    oneToBeFeared.handleAirshipDoorTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
    oneToBeFeared.handleOnEventUpdate(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    oneToBeFeared.handleOnEventFinish(player, csid, option)
end

return entity
