-----------------------------------
-- Area: Oldton Movalpolos
--  NPC: Koblakiq
-- Type: NPC Quest
-- !pos -64.851 21.834 -117.521 11
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(13)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
