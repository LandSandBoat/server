-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Vincent
-- Type: Abyssea Warp NPC
-- !pos 4 0 -65 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.warpNPCOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.abyssea.warpNPCOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.warpNPCOnEventFinish(player, csid, option, npc)
end

return entity
