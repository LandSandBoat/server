-----------------------------------
-- Area: Monarch_Linn
--  NPC: Spatial Displacement
-- !pos -35 -1 -539 31
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getPreviousZone() == xi.zone.RIVERNE_SITE_B01 then
        player:startEvent(10) -- To Riv Site B
    else
        -- Instead of a strict requirement, allow the player to
        -- exit the area in cases of teleporting in (GM), or if for
        -- some reason the prevZone value was lost or changed.

        player:startEvent(11) -- To Riv Site A
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 11 and option == 1 then
        player:setPos(-508.582, -8.471, -387.670, 92, 30) -- To Riv Site A (Retail confirmed)
    elseif csid == 10 and option == 1 then
        player:setPos(-533.690, -20.5, 503.656, 224, 29) -- To Riv Site B (Retail confirmed)
    end
end

return entity
