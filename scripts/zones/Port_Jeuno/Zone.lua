-----------------------------------
-- Zone: Port_Jeuno (246)
-----------------------------------
local ID = require('scripts/zones/Port_Jeuno/IDs')
require('scripts/globals/conquest')
require('scripts/globals/settings')
require('scripts/globals/chocobo')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1
    local month = tonumber(os.date("%m"))
    local day = tonumber(os.date("%d"))

    -- Retail start/end dates vary, set to Dec 5th through Jan 5th.
    if
        (month == 12 and day >= 5) or
        (month == 1 and day <= 5)
    then
        player:ChangeMusic(0, 239)
        player:ChangeMusic(1, 239)
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

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onTransportEvent = function(player, transport)
    if transport == 223 then -- San d'Oria Airship
        player:startEvent(10010)
        if player:getLocalVar('[AIRSHIP]Paid') == 1 then
            player:startEvent(10002)
        else
            player:setPos(-77.0152, 8.0021, 40.8033, 195)
            player:setLocalVar('[AIRSHIP]Paid', 0)
        end
    elseif transport == 224 then -- Bastok Airship
        player:startEvent(10012)
        if player:getLocalVar('[AIRSHIP]Paid') == 1 then
            player:startEvent(10002)
        else
            player:setPos(-60.9037, 8.0007, -41.2909, 64)
            player:setLocalVar('[AIRSHIP]Paid', 0)
        end
    elseif transport == 225 then -- Windurst Airship
        if player:getLocalVar('[AIRSHIP]Paid') == 1 then
            player:startEvent(10011)
        else
            player:setPos(2.9721, 8.0018, -40.1178, 65)
            player:setLocalVar('[AIRSHIP]Paid', 0)
        end
    elseif transport == 226 then -- Kazham Airship
        player:startEvent(10013)
        if player:getLocalVar('[AIRSHIP]Paid') == 1 then
            player:startEvent(10002)
        else
            player:setPos(-12.9056, 8.0015, 40.2401, 191)
            player:setLocalVar('[AIRSHIP]Paid', 0)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 10010 then
        player:setPos(0, 0, 0, 0, 223)
        player:setLocalVar('[AIRSHIP]Paid', 1)
    elseif csid == 10011 then
        player:setPos(0, 0, 0, 0, 225)
        player:setLocalVar('[AIRSHIP]Paid', 1)
    elseif csid == 10012 then
        player:setPos(0, 0, 0, 0, 224)
        player:setLocalVar('[AIRSHIP]Paid', 1)
    elseif csid == 10013 then
        player:setPos(0, 0, 0, 0, 226)
        player:setLocalVar('[AIRSHIP]Paid', 1)
    elseif csid == 54 and option == 0 then
        player:setLocalVar('[AIRSHIP]Paid', 0)
    elseif csid == 53 and option == 0 then
        player:setLocalVar('[AIRSHIP]Paid', 0)
    elseif csid == 52 and option == 0 then
        player:setLocalVar('[AIRSHIP]Paid', 0)
    elseif csid == 55 and option == 0 then
        player:setLocalVar('[AIRSHIP]Paid', 0)
    end
end

return zoneObject
