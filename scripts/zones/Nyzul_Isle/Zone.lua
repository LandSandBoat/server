-----------------------------------
-- Zone: Nyzul_Isle
-----------------------------------
local ID = require('scripts/zones/Nyzul_Isle/IDs')
require('scripts/globals/missions')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onInstanceZoneIn = function(player, instance)
    if player:getInstance() == nil then
        player:setPos(0, 0, 0, 0, 72)
        return
    end

    local pos = player:getPos()
    if pos.x == 0 and pos.y == 0 and pos.z == 0 then
        local entrypos = instance:getEntryPos()
        player:setPos(entrypos.x, entrypos.y, entrypos.z, entrypos.rot)
    end

    player:entityVisualPacket("1pa1")
    player:entityVisualPacket("1pb1")
    player:entityVisualPacket("2pb1")
end

-- NOTE: This is called after onInstanceZoneIn for the fade in cutscene.  onInstanceZoneIn
-- does not consider event returns.
zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    -- This event is common to all zone in, and is fade from black
    cs = 51

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 1 then
        player:setPos(0, 0, 0, 0, xi.zone.ALZADAAL_UNDERSEA_RUINS)
    end
end

zoneObject.onInstanceLoadFailed = function()
    return xi.zone.ALZADAAL_UNDERSEA_RUINS
end

return zoneObject
