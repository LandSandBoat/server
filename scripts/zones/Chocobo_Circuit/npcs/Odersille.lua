-----------------------------------
-- Area: Chocobo_Circuit
-- NPC: Odersille
-- !pos -11.523 -14.500 -133.451 70
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(331)
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinsih = function(player, csid, option)
    if
        csid == 331 and
        option == 1
    then
        player:setpos(-251.1373, -5.000, -489.9807) -- exits to saffa
    end
end

return entity
