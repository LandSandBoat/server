-----------------------------------
-- Area: Southern San d'Oria
--  NPC: Ullasa
--  General Info NPC
-----------------------------------
---@type TNpcEntity
local entity = {}

entity.onTrigger = function(player, npc)
    if player:getCharVar('UnderOathCS') == 2 then  -- Quest: Under Oath - PLD AF3
        player:startEvent(40)
    else
        player:startEvent(39)
    end
end

entity.onEventFinish = function(player, csid, option, npc)
    if csid == 40 then
        player:setCharVar('UnderOathCS', 3) -- Quest: Under Oath - PLD AF3
    end
end

return entity
