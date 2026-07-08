-----------------------------------
-- Area: Toraimarai Canal
--  NPC: Transporter
-- Involved In Windurst Mission 7-1
-- !pos 182 11 -60 169
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(71)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 71 and option == 1 then
        player:setPos(0, 0, -22, 192, 242)
    end
end

return entity
