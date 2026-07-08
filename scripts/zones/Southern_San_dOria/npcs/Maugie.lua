-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Maugie
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 12) -- FLYERS FOR REGINE
end

return entity
