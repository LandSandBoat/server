-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Daggao
-- Involved in Quest: Peace for the Spirit, Lure of the Wildcat (San d'Oria)
-- !pos 89 0 119 230
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('peaceForTheSpiritCS') == 3 then
        player:startEvent(72)
    elseif player:getCharVar('peaceForTheSpiritCS') == 5 then
        player:startEvent(73)
    else
        player:startEvent(60)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 72 then
        player:setCharVar('peaceForTheSpiritCS', 4)
    end
end

return entity
