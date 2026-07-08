-----------------------------------
-- Area: Monarch_Linn
--  NPC: Spatial Displacement (Successful BCNM Exit)
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(7)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 7 and option == 1 then
        player:setPos(-538.526, -29.5, 359.219, 255, 25) -- back to Misareaux Coast (Retail confirmed)
    end
end

return entity
