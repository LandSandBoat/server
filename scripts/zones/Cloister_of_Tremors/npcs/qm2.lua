-----------------------------------
-- Area: Cloister of Tremors
--  NPC: qm2 (???)
-- Involved in Quest: Open Sesame
-- Notes: Used to obtain a Tremor Stone
-- !pos -545.184, 1.855, -495.693 209
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    npcUtil.giveItem(player, xi.item.TREMORSTONE)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
