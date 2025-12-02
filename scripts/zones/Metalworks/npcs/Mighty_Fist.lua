-----------------------------------
-- Area: Metalworks
-- NPC: Metal Fist
-- !pos -47 2 -30 237
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getLocalVar('spokenMetalFist') == 0 then
        return player:startEvent(561)
    else
        return player:startEvent(560)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 561 then
        player:setLocalVar('spokenMetalFist', 1)
    end
end

return entity
