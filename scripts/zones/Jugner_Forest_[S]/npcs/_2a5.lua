-----------------------------------
-- Area: Jugner Forest (S)
--  NPC: Wooden Gate
-- !pos -200 -10.965 -511.129 82
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(104)
end

entity.onEventFinish = function(player, csid, option, npc)
    if option == 1 then
        player:setPos(231.029, -0.083, 19.975, 128, xi.zone.LA_VAULE_S)
    end
end

return entity
