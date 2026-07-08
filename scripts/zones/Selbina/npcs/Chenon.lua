-----------------------------------
-- Area: Selbina
--  NPC: Chenon
-- Type: Fish Ranking NPC
-- !pos -13.472 -8.287 9.497 248
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.fishingContest.onTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.fishingContest.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.fishingContest.onEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.fishingContest.onEventFinish(player, csid, option, npc)
end

return entity
