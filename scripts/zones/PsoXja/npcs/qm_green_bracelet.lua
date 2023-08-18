-----------------------------------
-- Area: Pso'xja
--  NPC: ???
-- !pos -329.980 28.300 -163.000 9
-----------------------------------
local ID = zones[xi.zone.PSOXJA]
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
