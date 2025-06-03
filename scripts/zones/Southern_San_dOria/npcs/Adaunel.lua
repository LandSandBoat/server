-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Adaunel
-- !pos 80 -7 -22 230
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 13) -- FLYERS FOR REGINE
end

return entity
