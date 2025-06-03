-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Rosel
-- Starts and Finishes Quest: Rosel the Armorer
-- !zone 230
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 11) -- FLYERS FOR REGINE
end

return entity
