-----------------------------------
-- Area: Southern San d`Oria
--  NPC: Alaune
-- Type: Tutorial NPC
-- !pos -90 1 -56 230
-----------------------------------
require("scripts/quests/tutorial")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.tutorial.onTrigger(player, npc, 916, 0)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    xi.tutorial.onEventFinish(player, csid, option, 916, 0)
end

return entity
