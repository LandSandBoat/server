-----------------------------------
-- Zone: Nyzul_Isle
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    local cs = -1

    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)

        return cs
    end

    local pos = player:getPos()

    if
        pos.x == 0 and
        pos.y == 0 and
        pos.z == 0
    then
        local entrypos = instance:getEntryPos()

        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    player:entityVisualPacket('1pa1')
    player:entityVisualPacket('1pb1')
    player:entityVisualPacket('2pb1')

    return cs
end

-- NOTE: This is called after onInstanceZoneIn for the fade in cutscene.
-- onInstanceZoneIn does not consider event returns.
zoneObject.onZoneIn = function(player, prevZone)
    -- This event is common to all zone in, and is fade from black
    return 51
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 1 then
        player:setPos(0, 0, 0, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)
    end
end

zoneObject.onInstanceLoadFailed = function()
    return xi.zone.ALZADAAL_UNDERSEA_RUINS
end

return zoneObject
