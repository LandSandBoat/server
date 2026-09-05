-----------------------------------
-- Zone: Port_Jeuno (246)
-----------------------------------
---@type TZone
local zoneObject = {}

local berths =
{
    [xi.zone.SAN_DORIA_JEUNO_AIRSHIP] = { keyItem = xi.ki.AIRSHIP_PASS,            board = 10010, ashore = 10014 },
    [xi.zone.WINDURST_JEUNO_AIRSHIP ] = { keyItem = xi.ki.AIRSHIP_PASS,            board = 10011, ashore = 10015 },
    [xi.zone.BASTOK_JEUNO_AIRSHIP   ] = { keyItem = xi.ki.AIRSHIP_PASS,            board = 10012, ashore = 10016 },
    [xi.zone.KAZHAM_JEUNO_AIRSHIP   ] = { keyItem = xi.ki.AIRSHIP_PASS_FOR_KAZHAM, board = 10013, ashore = 10017 },
}

zoneObject.onInitialize = function(zone)
    xi.chocobo.initZone(zone)
    zone:registerCuboidTriggerArea(474, -84.1, 7.1,  113.1, -51.9, 12.9,  141.2) -- San d'Oria airship berth
    zone:registerCuboidTriggerArea(475, -86.1, 7.1, -141.2, -53.9, 12.9, -113.1) -- Bastok airship berth
    zone:registerCuboidTriggerArea(476, -22.1, 7.1, -141.2,  10.1, 12.9, -113.1) -- Windurst airship berth
    zone:registerCuboidTriggerArea(477, -20.1, 7.1,  113.1,  12.1, 12.9,  141.2) -- Kazham airship berth
end

zoneObject.onZoneIn = function(player, prevZone)
    local month = JstMonth()
    local day = JstDayOfTheMonth()

    -- Retail start/end dates vary, set to Dec 5th through Jan 5th.
    if
        (month == 12 and day >= 5) or
        (month == 1 and day <= 5)
    then
        player:changeMusic(xi.musicSlot.ZONE_DAY, 239)
        player:changeMusic(xi.musicSlot.ZONE_NIGHT, 239)
    end

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local arrivalFlags = bit.bor(xi.cutsceneFlag.RESET_CAMERA, xi.cutsceneFlag.NO_PCS)

        if prevZone == xi.zone.SAN_DORIA_JEUNO_AIRSHIP then
            player:setPos(-87.000, 12.000, 116.000, 128)
            return { 10018, -1, arrivalFlags }
        elseif prevZone == xi.zone.BASTOK_JEUNO_AIRSHIP then
            player:setPos(-50.000, 12.000, -116.000, 0)
            return { 10020, -1, arrivalFlags }
        elseif prevZone == xi.zone.WINDURST_JEUNO_AIRSHIP then
            player:setPos(16.000, 12.000, -117.000, 0)
            return { 10019, -1, arrivalFlags }
        elseif prevZone == xi.zone.KAZHAM_JEUNO_AIRSHIP then
            player:setPos(-24.000, 12.000, 116.000, 128)
            return { 10021, -1, arrivalFlags }
        end
    end

    return xi.moghouse.onMoghouseZoneEvent(player, prevZone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportName)
    local berth = berths[prevZoneId]

    if not berth then
        return
    end

    if not player:hasKeyItem(berth.keyItem) then
        player:startEvent(berth.ashore)
        return
    end

    player:startEvent(berth.board, {
        isHidden = true,
        flags    = bit.bor(xi.cutsceneFlag.NO_PCS, xi.cutsceneFlag.SEND_POSITION, xi.cutsceneFlag.NO_IDLE_WAIT),
    })
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
