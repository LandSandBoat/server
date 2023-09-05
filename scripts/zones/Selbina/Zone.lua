-----------------------------------
-- Zone: Selbina (248)
-----------------------------------
local ID = require('scripts/zones/Selbina/IDs')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    SetExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
    InitializeFishingContestSystem()
end

zoneObject.onGameHour = function(zone)
    SetServerVariable("Selbina_Destination", math.random(1, 100))
end

zoneObject.onZoneTick = function(zone)
    ProgressFishingContest()
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if
            prevZone == xi.zone.SHIP_BOUND_FOR_SELBINA or
            prevZone == xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES
        then
            local ship = GetNPCByID(ID.npc.SHIP)
            ship:setAnimBegin(VanadielTime())

            cs = 202
            player:setPos(32.500, -2.500, -45.500, 192)
        else
            player:setPos(17.981, -16.806, 99.83, 64)
        end
    end

    if player:getZPos() < -59.5 then -- fixing player position if logged off / crashed on ship
        player:setPos(18.05, -1.38, -56.75)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTransportEvent = function(player, transport)
    -- if player:getLocalVar('[BOAT]Paid') == 1 then
        player:startEvent(200)
    -- else
    --     player:setPos(33.1626, -2.5586, -26.3290, 69)
    --     player:setLocalVar('[BOAT]Paid', 0)
    -- end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 200 then
        if GetServerVariable("Selbina_Destination") >= 75 then
            player:setPos(0, 0, 0, 0, xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES)
        else
            player:setPos(0, 0, 0, 0, xi.zone.SHIP_BOUND_FOR_MHAURA)
        end
    elseif csid == 220 and option == 0 then
        player:setLocalVar('[BOAT]Paid', 0)
    elseif csid == 202 then
        player:setLocalVar('[BOAT]Paid', 1)
    end
end

return zoneObject
