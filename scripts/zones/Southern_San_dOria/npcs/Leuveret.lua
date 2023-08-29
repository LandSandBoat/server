-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Leuveret
-- Type: General Info NPC
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 14) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    player:startEvent(621)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
