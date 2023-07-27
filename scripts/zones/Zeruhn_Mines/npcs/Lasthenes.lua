-----------------------------------
-- Area: Zeruhn Mines
--  NPC: Lasthenes
-- Notes: Opens Gate
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if player:getXPos() > -79.5 then
        player:startEvent(180)
    else
        player:startEvent(181)
    end
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
end

return entity
