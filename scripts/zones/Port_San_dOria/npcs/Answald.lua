-----------------------------------
-- Area: Port San d'Oria
--  NPC: Answald
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 0) -- FLYERS FOR REGINE
end

return entity
