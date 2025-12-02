-----------------------------------
-- Zone: Mhaura (249)
-----------------------------------
local ID = zones[xi.zone.MHAURA]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onGameHour = function(zone)
    local laughingBison = GetNPCByID(ID.npc.LAUGHING_BISON)
    if laughingBison then
        -- Script for Laughing Bison sign flip animations
        local timer = 1152 - (GetSystemTime() - 1009810802) % 1152

        -- Next ferry is Al Zhabi for higher values.
        if timer >= 576 then
            laughingBison:setAnimationSub(1)
        else
            laughingBison:setAnimationSub(0)
        end
    end

    local destinationId = math.random(1, 100) <= 10 and xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES or xi.zone.SHIP_BOUND_FOR_SELBINA
    zone:setLocalVar('[Pirate]Zone', destinationId)
end

zoneObject.onInitialize = function(zone)
    xi.server.setExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if
            player:hasKeyItem(xi.ki.FERRY_TICKET) and
            (prevZone == xi.zone.SHIP_BOUND_FOR_MHAURA or
            prevZone == xi.zone.OPEN_SEA_ROUTE_TO_MHAURA or
            prevZone == xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES)
        then
            cs = 202
            player:setPos(14.960, -3.430, 18.423, 192)
        else
            player:setPos(0.003, -6.252, 117.971, 65)
        end
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    if player:isInEvent() then
        return
    end

    if
        prevZoneId == xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI or
        prevZoneId == xi.zone.OPEN_SEA_ROUTE_TO_MHAURA
    then
        if
            xi.settings.main.ENABLE_TOAU == 1 and
            player:hasKeyItem(xi.ki.BOARDING_PERMIT) and
            player:hasKeyItem(xi.ki.FERRY_TICKET)
        then
            player:startEvent(200)
        else
            player:startEvent(204)
            player:messageSpecial(ID.text.DO_NOT_POSSESS, xi.ki.BOARDING_PERMIT)
        end
    else
        if player:hasKeyItem(xi.ki.FERRY_TICKET) then
            player:startEvent(200)
        else
            player:startEvent(204)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 200 then
        local departureTime = VanadielHour() % 8
        local zone          = player:getZone()
        local destinationId = zone and zone:getLocalVar('[Pirate]Zone') or xi.zone.SHIP_BOUND_FOR_SELBINA

        -- To Selbina.
        if departureTime == 0 then
            player:setPos(0, 0, 0, 0, destinationId)

        -- To Al Zahbi
        elseif departureTime == 4 then
            player:setPos(0, 0, 0, 0, xi.zone.OPEN_SEA_ROUTE_TO_AL_ZAHBI)

        -- Something went wrong, dump them on the dock for safety.
        else
            player:setPos(8, -1, 5, 62, xi.zone.MHAURA)
        end
    end
end

return zoneObject
