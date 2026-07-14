-----------------------------------
-- Area: Ra'Kaznar Inner Court
--  NPC: Vertical Transit Device
-- !pos -492.79 -521.136 20 276
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(83, 1, 300, 1, 100, 0, 1, 0, 0)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 83 and option == 4 then
        player:setPos(631.2, 100.1, -20.0, 0, xi.zone.OUTER_RAKAZNAR)
    end
end

return entity
