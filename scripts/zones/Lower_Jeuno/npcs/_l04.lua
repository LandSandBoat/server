-----------------------------------
-- Area: Lower Jeuno
--  NPC: Streetlamp
-- Involved in Quests: Community Service
-- !pos -80 0 -111 245
-----------------------------------
local lowerJeunoGlobal = require('scripts/zones/Lower_Jeuno/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    lowerJeunoGlobal.lampTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    lowerJeunoGlobal.lampEventFinish(player, csid, option, 4)
end

return entity
