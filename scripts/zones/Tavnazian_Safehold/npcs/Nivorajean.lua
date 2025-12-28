-----------------------------------
-- Area: Tavnazian Safehold
--  NPC: Nivorajean
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    -- Dialgoue cycles
    if player:getLocalVar('spokenNivorajean') == 0 then
        player:startEvent(382)
    else
        player:startEvent(221)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 382 then
        player:setLocalVar('spokenNivorajean', 1)
    else
        player:setLocalVar('spokenNivorajean', 0)
    end
end

return entity
