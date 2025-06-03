-----------------------------------
-- Area: Port San d'Oria
--  NPC: Auvare
-----------------------------------
require('scripts/quests/flyers_for_regine')
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    quests.ffr.onTrade(player, npc, trade, 4) -- FLYERS FOR REGINE
end

return entity
