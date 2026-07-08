-----------------------------------
-- Area: Bastok Markets (S)
--  NPC: Red Canyon
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(380, 0, 147, 192, 88)
    end
end

return entity
