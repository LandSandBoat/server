-----------------------------------
-- Zone: Selbina (248)
-----------------------------------
local ID = zones[xi.zone.SELBINA]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.server.setExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
    InitializeFishingContestSystem()
end

zoneObject.onGameHour = function(zone)
    local destinationId = math.randomInt(1, 100) <= 10 and xi.zone.SHIP_BOUND_FOR_MHAURA_PIRATES or xi.zone.SHIP_BOUND_FOR_MHAURA
    zone:setLocalVar('[Pirate]Zone', destinationId)
end

zoneObject.onZoneTick = function(zone)
    if xi.settings.main.AUTO_FISHING_CONTEST then
        ProgressFishingContest()
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { }

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if
            player:hasKeyItem(xi.ki.FERRY_TICKET) and
            (prevZone == xi.zone.SHIP_BOUND_FOR_SELBINA or
            prevZone == xi.zone.SHIP_BOUND_FOR_SELBINA_PIRATES)
        then
            cs = { 202, -1, bit.bor(xi.cutsceneFlag.RESET_CAMERA, xi.cutsceneFlag.NO_PCS) }
            player:setPos(32.500, -2.500, -45.500, 192)
        else
            player:setPos(17.981, -16.806, 99.83, 64)
        end
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    -- TODO don't double fire transport events (a ship "arrives" from normal and pirates zones at the same time and triggers a transport event)
    if player:isInEvent() then
        return
    end

    if player:hasKeyItem(xi.ki.FERRY_TICKET) then
        player:startEvent(200, {
            isHidden = true,
            flags    = bit.bor(
                xi.cutsceneFlag.RESET_CAMERA,
                xi.cutsceneFlag.NO_PCS,
                xi.cutsceneFlag.NO_IDLE_WAIT
            ),
        })
    else
        player:startEvent(204)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    -- Transport event.
    if csid == 200 then
        local zone          = player:getZone()
        local destinationId = zone and zone:getLocalVar('[Pirate]Zone') or xi.zone.SHIP_BOUND_FOR_MHAURA
        player:setPos(0, 0, 0, 0, destinationId)
    end
end

return zoneObject
