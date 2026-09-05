-----------------------------------
-- Zone: Port_Windurst (240)
-----------------------------------
local ID = zones[xi.zone.PORT_WINDURST]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.server.setExplorerMoogles(ID.npc.EXPLORER_MOOGLE)
    zone:registerCuboidTriggerArea(416, 235.43, -6.8, 53.05, 263.51, -1.0, 85.3, -2.3562) -- Jeuno airship boarding area, off-axis
end

zoneObject.onZoneIn = function(player, prevZone)
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.WINDURST_JEUNO_AIRSHIP then
            player:setPos(228.000, -3.000, 76.000, 160)
            return { 10004, -1, bit.bor(xi.cutsceneFlag.RESET_CAMERA, xi.cutsceneFlag.NO_PCS) }
        end
    end

    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportName)
    if not player:hasKeyItem(xi.ki.AIRSHIP_PASS) then
        player:startEvent(10003)
        return
    end

    player:startEvent(10002, {
        isHidden = true,
        flags    = bit.bor(
            xi.cutsceneFlag.RESET_CAMERA,
            xi.cutsceneFlag.SEND_POSITION,
            xi.cutsceneFlag.NO_IDLE_WAIT
        ),
    })
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 10002 then
        player:setPos(0, 0, 0, 0, 225)
    end
end

return zoneObject
