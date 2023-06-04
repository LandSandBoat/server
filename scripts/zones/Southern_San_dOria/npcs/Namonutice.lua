-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Namonutice
-- Fame Checker
-- !zone 230
-----------------------------------
require("scripts/globals/quests")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(31, player:getFame(xi.quest.fame_area.SANDORIA))
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
end

return entity
