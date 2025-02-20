-----------------------------------
-- Zone: Port_Jeuno (246)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1
    local month = tonumber(os.date('%m'))
    local day = tonumber(os.date('%d'))

    -- Retail start/end dates vary, set to Dec 5th through Jan 5th.
    if
        (month == 12 and day >= 5) or
        (month == 1 and day <= 5)
    then
        player:changeMusic(0, 239)
        player:changeMusic(1, 239)
    end

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.SAN_DORIA_JEUNO_AIRSHIP then
            cs = 10018
            player:setPos(-87.000, 12.000, 116.000, 128)
        elseif prevZone == xi.zone.BASTOK_JEUNO_AIRSHIP then
            cs = 10020
            player:setPos(-50.000, 12.000, -116.000, 0)
        elseif prevZone == xi.zone.WINDURST_JEUNO_AIRSHIP then
            cs = 10019
            player:setPos(16.000, 12.000, -117.000, 0)
        elseif prevZone == xi.zone.KAZHAM_JEUNO_AIRSHIP then
            cs = 10021
            player:setPos(-24.000, 12.000, 116.000, 128)
        else
            local position = math.random(1, 3) - 2
            player:setPos(-192.5 , -5, position, 0)
        end
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTransportEvent = function(player, transport)
    if transport == 223 then
        player:startEvent(10010)
    elseif transport == 224 then
        player:startEvent(10012)
    elseif transport == 225 then
        player:startEvent(10011)
    elseif transport == 226 then
        player:startEvent(10013)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 10010 then
        player:setPos(0, 0, 0, 0, 223)
    elseif csid == 10011 then
        player:setPos(0, 0, 0, 0, 225)
    elseif csid == 10012 then
        player:setPos(0, 0, 0, 0, 224)
    elseif csid == 10013 then
        player:setPos(0, 0, 0, 0, 226)
    end
end

return zoneObject
