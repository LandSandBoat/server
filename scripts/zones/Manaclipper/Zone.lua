-----------------------------------
-- Zone: Manaclipper
-----------------------------------
local ID = zones[xi.zone.MANACLIPPER]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    xi.manaclipper.onZoneIn(player)

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(16.568, -3, 2.421, 128)
    end

    local zoredonite = GetMobByID(ID.mob.ZOREDONITE)
    if not zoredonite then
        return cs
    end

    local currentTime       = GetSystemTime()
    local zoredoniteRespawn = currentTime > zoredonite:getLocalVar('respawn')
    local zoredoniteWindow  = currentTime > zoredonite:getLocalVar('zoneWindow')

    if zoredoniteWindow then
        zoredonite:setLocalVar('zoneWindow', GetSystemTime() + 20) -- Block multiple spawn chance rolls per boat ride.
        if
            zoredoniteRespawn and
            math.random(1, 100) <= 30
        then
            zoredonite:setRespawnTime(math.random(120, 480))
        end
    end

    return cs
end

zoneObject.onTransportEvent = function(player, prevZoneId, transportId)
    player:startEvent(100)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 100 then
        player:setPos(0, 0, 0, 0, xi.zone.BIBIKI_BAY)
    end
end

return zoneObject
