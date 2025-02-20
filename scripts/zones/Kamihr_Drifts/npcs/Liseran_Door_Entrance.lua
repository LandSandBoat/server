-----------------------------------
-- Area: Kamihr Drifts
--  NPC: Liseran Door Entrance
-- Zones to Outer Ra'Kaznar (zone 274)
-- !pos -34.549 -181.334 -20.031 274
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(34)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 34 and option == 1 then
        player:setPos(-39.846, -179.333, -19.921, 131, 274)
    end
end

return entity
