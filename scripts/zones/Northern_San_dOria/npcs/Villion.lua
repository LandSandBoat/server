-----------------------------------
-- Area: Northern San d'Oria
--  NPC: Villion
-- Type: Adventurer's Assistant NPC
--  Involved in Quest: Flyers for Regine
-- !pos -157.524 4.000 263.818 231
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 9) -- FLYERS FOR REGINE
end

return entity
