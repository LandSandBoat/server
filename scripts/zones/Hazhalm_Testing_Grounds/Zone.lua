-----------------------------------
-- Zone: Hazhalm_Testing_Grounds (78)
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneOut = function(player)
    local inEinherjar = player:getCharVar('[ein]chamber')
    if inEinherjar then
        local chamberData = xi.einherjar.getChamber(inEinherjar)
        if chamberData then
            xi.einherjar.onZoneOut(chamberData, player)
        end
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(652.174, -272.632, -104.92, 148)
    end

    -- Eject players past the gate if they no longer have a valid reservation
    -- TODO: Will likely conflict with The Rider Cometh
    local inEinherjar = player:getCharVar('[ein]chamber')
    if inEinherjar then
        local chamberData = xi.einherjar.getChamber(inEinherjar)
        if chamberData then
            local validForChamber = xi.einherjar.onReconnection(chamberData, player)
            if validForChamber then
                return -1
            end
        end
    end

    if player:getXPos() < 486 then
        -- Cutscene warps them back to entrance
        cs = 4
    end

    return cs
end

zoneObject.onZoneTick = function(zone)
    xi.einherjar.onZoneTick(zone)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
