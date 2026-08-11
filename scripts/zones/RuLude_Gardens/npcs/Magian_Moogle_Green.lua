-----------------------------------
-- Area: Ru'Lude Gardens
--  NPC: Magian Moogle (Green Bobble)
-- Type: Magian Trials NPC (Job Emotes)
-- !pos -4.558 2.451 111.306 243
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrade = function(player, npc, trade)
    xi.magian.magianOnTrade(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    xi.magian.magianOnTrigger(player, npc)
end

entity.onEventUpdate = function(player, csid, option, npc)
    xi.magian.magianEventUpdate(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.magian.magianOnEventFinish(player, csid, option, npc)
end

return entity
