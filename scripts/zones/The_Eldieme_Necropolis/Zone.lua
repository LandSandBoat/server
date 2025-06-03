-----------------------------------
-- Zone: The Eldieme Necropolis (195)
-----------------------------------
local eldiemeID = zones[xi.zone.THE_ELDIEME_NECROPOLIS]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.treasure.initZone(zone)

    -- Give the Acting in Good Faith ??? a random spawn
    local qm1 = GetNPCByID(eldiemeID.npc.QM1)
    if qm1 then
        qm1:setPos(unpack(eldiemeID.npc.QM1_POS[math.random(1, 4)]))
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    -- RNG AF2
    if player:getCharVar('fireAndBrimstone') == 2 then
        cs = 4
    end

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-438.878, -26.091, 540.004, 126)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 4 then
        player:setCharVar('fireAndBrimstone', 3)
    end
end

return zoneObject
