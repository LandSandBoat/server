-----------------------------------
-- Area: Lower Jeuno
--  NPC: Streetlamp
-- Involved in Quests: Community Service
-- !pos -32 0 -28 245
-----------------------------------
local lowerJeunoGlobal = require('scripts/zones/Lower_Jeuno/globals')
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    lowerJeunoGlobal.lampTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    lowerJeunoGlobal.lampEventFinish(player, csid, option, 9)
end

return entity
