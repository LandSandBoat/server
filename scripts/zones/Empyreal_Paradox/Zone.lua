-----------------------------------
-- Zone: Empyreal_Paradox
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerTriggerArea(1, 538, -2, -501,  542, 0, -497) -- to The Garden of Ru'hmet
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getCharVar('ApocalypseNigh') == 5 then
        cs = 7
    elseif player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN then
        local promathiaStatus = player:getCharVar('PromathiaStatus')

        if promathiaStatus == 3 then
            cs = 6
        elseif promathiaStatus == 4 then
            cs = 3
        end
    elseif
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        --player:setPos(502, 0, 500, 222) -- BC Area
        player:setPos(539, -1, -500, 69)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
    if triggerArea:GetTriggerAreaID() == 1 then
        player:startEvent(100)
    end
end

zoneObject.onTriggerAreaLeave = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 3 then
        npcUtil.giveKeyItem(player, xi.ki.TEAR_OF_ALTANA)
        player:setPos(0.18, -10, -470.43, 63, xi.zone.ALTAIEU)
    elseif csid == 6 then
        player:setCharVar('Promathia_kill_day', getMidnight())
        player:setCharVar('PromathiaStatus', 4)
        player:setPos(540, 0, -514, 63, xi.zone.EMPYREAL_PARADOX)
    elseif csid == 7 then
        player:setPos(-.0745, -10, -465.1132, 63, 33)
    elseif csid == 100 and option == 1 then
        player:setPos(-420, -1, 379.900, 62, 35)
    end
end

return zoneObject
