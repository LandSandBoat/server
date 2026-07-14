-----------------------------------
-- Area: Outer Ra'Kaznar
--  NPC: Vertical Transit Device
-- !pos 626.8 99 -20 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(49, 0, 300, 0, 100, 0, 7, 0, 0)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 49 and option == 7 then
        player:setPos(-487.5, -520.0, 20.0, 0, xi.zone.RAKAZNAR_INNER_COURT)
    end
end

return entity
