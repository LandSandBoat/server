-----------------------------------
-- Area: Upper Jeuno
-- NPC: Hinda
-- !pos -25.605 -1.499 19.891
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getLocalVar('spokenHinda') == 0 then
        return player:startEvent(161)
    else
        return player:startEvent(10128)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 161 then
        player:setLocalVar('spokenHinda', 1)
    else
        player:setLocalVar('spokenHinda', 0)
    end
end

return entity
