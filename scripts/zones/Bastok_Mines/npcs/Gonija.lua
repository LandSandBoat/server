-----------------------------------
-- Area: Bastok Mines
--  NPC: Gonija
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- param [0] is related to having a chocobo in raising. it adds more help text to the event.
    player:startEvent(534, { [0] = 0, [1] =  math.floor(player:getCharSkillLevel(xi.skill.DIG) / 10) })
end

return entity
