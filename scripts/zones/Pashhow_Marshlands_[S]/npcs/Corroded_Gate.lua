-----------------------------------
-- Area : Pashhow Marshlands [S] (90)
--  NPC : Corroded Gate
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    player:startEvent(102)
end

entity.onEventUpdate = function(player, csid, option, npc)
end

entity.onEventFinish = function(player, csid, option, npc)
    if
        csid == 102 and
        option == 1
    then
        player:setPos(-297.365, 1.7, 96.049, 0, xi.zone.BEADEAUX_S)
    end
end

return entity
