-----------------------------------
-- Area: Lower Jeuno
--  NPC: Streetlamp
-- Involved in Quests: Community Service
-- !pos -107 0 -158 245
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
    LOWER_JEUNO.lampEventFinish(player, csid, option, 0)
end

return entity
