-----------------------------------
-- Area: West Sarutabaruta
--  NPC: Survival Guide
-----------------------------------
require('scripts/quests/tutorial')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, targetNpc)
    xi.tutorial.onGuideTriggerSecond(player)
    xi.survivalGuide.onTrigger(player)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.survivalGuide.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.survivalGuide.onEventFinish(player, csid, option, npc)
end

return entity
