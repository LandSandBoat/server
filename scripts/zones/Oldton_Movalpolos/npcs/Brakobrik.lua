-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Brakobrik
-- !pos 164.605 10.992 -91.253 11
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(2)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
