-----------------------------------
-- Area: Windurst Waters North
--  NPC: Angelica
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Dialgoue cycles
    if player:getLocalVar('spokenAngelica') == 0 then
        player:startEvent(86)
    else
        player:startEvent(87)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 86 then
        player:setLocalVar('spokenAngelica', 1)
    elseif csid == 87 then
        player:setLocalVar('spokenAngelica', 0)
    end
end

return entity
