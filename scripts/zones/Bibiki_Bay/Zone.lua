-----------------------------------
--
-- Zone: Bibiki_Bay (4)
--
-----------------------------------
local ID = require("scripts/zones/Bibiki_Bay/IDs")
require("scripts/globals/chocobo_digging")
require("scripts/globals/manaclipper")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    zone:registerRegion(1,  474, -10,  667,  511, 10,  708) -- Manaclipper while docked at Sunset Docks
    zone:registerRegion(2, -410, -10, -385, -371, 10, -343) -- Manaclipper while docked at Purgonorgo Isle
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        if prevZone == tpz.zone.MANACLIPPER then
            cs = tpz.manaclipper.onZoneIn(player)
        else
            player:setPos(669.917, -23.138, 911.655, 111)
        end
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
    tpz.manaclipper.aboard(player, region:GetRegionID(), true)
end

function onRegionLeave(player, region)
    tpz.manaclipper.aboard(player, region:GetRegionID(), false)
end

function onTransportEvent(player, transport)
    tpz.manaclipper.onTransportEvent(player, transport)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if csid == 12 then
        player:startEvent(10) -- arrive at Sunset Docks CS
    elseif csid == 13 then
        player:startEvent(11) -- arrive at Purgonorgo Isle CS
    elseif csid == 14 or csid == 16 then
        player:setPos(0, 0, 0, 0, tpz.zone.MANACLIPPER)
    end
end
