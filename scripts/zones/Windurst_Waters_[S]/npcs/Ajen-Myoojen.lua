-----------------------------------
-- Area: Windurst Waters (S)
--  NPC: Ajen-Myoojen
-- !pos -44.542 -5.999 238.996 94
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(320, -4, -46, 192, 95)
    end
end

return entity
