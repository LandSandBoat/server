-----------------------------------
-- Area: Spire of Dem
--  NPC: Radiant Aureole
-- !pos 0.044 -119.249 -360.028 19
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(14)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 14 and option == 1 then
        player:setPos(139.974, 19.103, 219.989, 128, 108)     -- To Konschtat Highlands (R)
    end
end

return entity
