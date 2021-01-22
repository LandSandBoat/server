-----------------------------------
-- Area: Qufim_Island
--  NPC: Hieroglyphics
-- Dynamis Qufim Entrance
-- !pos 16 -19 162 126
-----------------------------------
require("scripts/globals/dynamis")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    dynamis.entryNpcOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    dynamis.entryNpcOnEventFinish(player, csid, option)
end

return entity
