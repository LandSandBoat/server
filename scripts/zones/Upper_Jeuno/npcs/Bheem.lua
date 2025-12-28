-----------------------------------
-- Area: Upper Jeuno
-- NPC: Bheem
-- !pos -90.009 0.0 169.885
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getLocalVar('spokenBheem') == 0 then
        return player:startEvent(10037)
    else
        return player:startEvent(157)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 10037 then
        player:setLocalVar('spokenBheem', 1)
    end
end

return entity
