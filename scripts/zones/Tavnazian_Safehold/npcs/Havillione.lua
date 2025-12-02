-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Havillione
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Dialgoue cycles
    if player:getLocalVar('spokenHavillione') == 0 then
        player:startEvent(383)
    else
        player:startEvent(320)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 383 then
        player:setLocalVar('spokenHavillione', 1)
    else
        player:setLocalVar('spokenHavillione', 0)
    end
end

return entity
