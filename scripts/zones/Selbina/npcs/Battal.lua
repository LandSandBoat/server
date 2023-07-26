-----------------------------------
-- Area: Selbina
--  NPC: Battal
-- Type: Event Scene Replayer
-- !pos -17.429 -11.604 25.966 248
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(1102)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
