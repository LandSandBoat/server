-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Adaunel
-- General Info NPC
-- !pos 80 -7 -22 230
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 13) -- FLYERS FOR REGINE
end

entity.onTrigger = function(player, npc)
    player:startEvent(656)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
