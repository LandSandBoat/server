-----------------------------------
-- Area: Temple of Uggalepih
--  NPC: Treasure Casket
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.caskets.onTrigger(player, npc)
end

entity.onTrade = function(player, npc, trade)
    xi.caskets.onTrade(player, npc, trade)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.caskets.onEventFinish(player, csid, option, npc)
end

return entity
