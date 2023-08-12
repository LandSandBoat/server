-----------------------------------
-- Area: Windurst Woods
--  NPC: Zahsa Syalmhaia
-- Type: Great War Veteran NPC
-- !pos 13.710 1.422 -83.198 241
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(797)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
