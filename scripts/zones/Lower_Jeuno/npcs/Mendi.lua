-----------------------------------
-- Area: Lower Jeuno
--  NPC: Mendi
-- Reputation NPC
-- !pos -55 5 -68 245
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if xi.events.skillUp.onNpcTrigger(npc, player) then
        return
    else
        player:startEvent(82, player:getFame(xi.fameArea.JEUNO))
    end
end

return entity
