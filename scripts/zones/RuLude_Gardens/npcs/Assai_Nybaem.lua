-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Assai Nybaem
-- !pos -32 0 -76 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.voidwalker.npcOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.voidwalker.npcOnEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.voidwalker.npcOnEventFinish(player, csid, option, npc)
end

return entity
