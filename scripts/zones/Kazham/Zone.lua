-----------------------------------
-- Zone: Kazham (250)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
    xi.chocoboGame.clearRecord(zone)
    zone:registerCuboidTriggerArea(512, -7.9, -6.8, 16.0, 20.2, -1.0, 48.3) -- Jeuno airship boarding area
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = { }

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        if prevZone == xi.zone.KAZHAM_JEUNO_AIRSHIP then
            cs = { 10002, -1, bit.bor(xi.cutsceneFlag.RESET_CAMERA, xi.cutsceneFlag.NO_PCS) }
        end

        player:setPos(-4.000, -3.000, 14.000, 66)
    end

    return cs
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportName)
    if not player:hasKeyItem(xi.ki.AIRSHIP_PASS_FOR_KAZHAM) then
        player:startEvent(10001)
        return
    end

    player:startEvent(10000, {
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
    if csid == 10000 then
        player:setPos(0, 0, 0, 0, 226)
    end
end

return zoneObject
