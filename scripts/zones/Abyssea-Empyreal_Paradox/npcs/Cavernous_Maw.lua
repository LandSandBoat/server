-----------------------------------
-- Area: Abyssea - Empyreal Paradox
--  NPC: Cavernous Maw
-- !pos 540.018 -499.999 -565.867 255
-- Teleports players to Qufim Island
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    xi.abyssea.exitMawOnTrigger(player, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    xi.abyssea.exitMawOnEventFinish(player, csid, option, npc)
end

return entity
