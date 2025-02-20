-----------------------------------
-- Area: Abyssea - Uleguerand
--  NPC: Cavernous Maw
-- !pos -246.000, -40.600, -520.000 253
-- Notes: Teleports Players to Xarcabard
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    player:startEvent(200)
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 200 and option == 1 then
        player:setPos(269, -7, -75, 192, 112)
    end
end

return entity
