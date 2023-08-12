-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Kuron-Makaron
-- Type: Morale Manager
-- !pos 10.422 -2.478 24.616 94
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(300)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
