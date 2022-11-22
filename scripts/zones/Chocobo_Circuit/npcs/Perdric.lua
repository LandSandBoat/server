-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Perdric
-- !pos -84.007 -14.500 -133.451 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(330)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
if
        csid == 330 and
        option == 1
    then
        player:setPos(-387.1529, -5.000, -469.9266) -- exits to mulitrand
    end
end

return entity
