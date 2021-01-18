-----------------------------------
-- Area: Lower Jeuno
--  NPC: Streetlamp
-- Involved in Quests: Community Service
-- !pos -72 6 -96 245
-----------------------------------
require("scripts/zones/Lower_Jeuno/globals")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    LOWER_JEUNO.lampTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    LOWER_JEUNO.lampEventFinish(player, csid, option, 5)
end

return entity
