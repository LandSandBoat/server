-----------------------------------
-- Area: Lower Jeuno
--  NPC: Streetlamp
-- Involved in Quests: Community Service
-- !pos -8 0 12 245
-----------------------------------
local lowerJeunoGlobal = require('scripts/zones/Lower_Jeuno/globals')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    lowerJeunoGlobal.lampTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    lowerJeunoGlobal.lampEventFinish(player, csid, option, 11)
end

return entity
