-----------------------------------
-- Area: Windurst Waters North
--  NPC: Buchi Kohmrijah
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Dialgoue cycles
    if player:getLocalVar('spokenBuchi') == 0 then
        player:startEvent(591)
    else
        player:startEvent(592)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 591 then
        player:setLocalVar('spokenBuchi', 1)
    else
        player:setLocalVar('spokenBuchi', 0)
    end
end

return entity
