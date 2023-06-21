-----------------------------------
-- Area: Port Jeuno
--  NPC: Door: Departures Exit (for San D'Oria)
-- !pos -76 8 54 246
-----------------------------------
-----------------------------------
local entity = {}

entity.onTrade = function(player, npc, trade)
end

entity.onTrigger = function(player, npc)
    if
        player:hasKeyItem(xi.ki.AIRSHIP_PASS) and
        player:getGil() >= 200
    then
        player:startEvent(38)
    else
        player:startEvent(46)
    end
end

entity.onEventUpdate = function(player, csid, option)
end

entity.onEventFinish = function(player, csid, option)
    if csid == 38 then
        local zPos = player:getZPos()

        if zPos >= 58 and zPos <= 61 then
            player:delGil(200)
        end
    end
end

return entity
