-----------------------------------
-- Area: Sauromugue Champaign [S]
--  NPC: Cavernous Maw
-- !pos 369 8 -227 98
-- Teleports Players to Sauromugue_Champaign
-----------------------------------
require("scripts/globals/maws")
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    tpz.maws.onTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    tpz.maws.onEventFinish(player, csid, option)
end

return entity
