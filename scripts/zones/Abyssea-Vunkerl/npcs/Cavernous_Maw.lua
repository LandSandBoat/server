-----------------------------------
-- Area: Abyssea - Vunkerl
--  NPC: Cavernous Maw
-- !pos -360.000 -46.750 700.000 217
-- Notes: Teleports Players to Jugner Forest
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(241, 0.001, 11, 42, 104)
    end
end

return entity
