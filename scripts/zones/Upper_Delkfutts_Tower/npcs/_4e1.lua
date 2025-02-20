-----------------------------------
-- Area: Upper Delkfutt's Tower
--  NPC: Door
-- !pos 315 16 20 158
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(2)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 2 and option == 1 then
        player:setPos(524, 16, 20, 0, 184)    -- to Lower Delkfutt's Tower
    end
end

return entity
