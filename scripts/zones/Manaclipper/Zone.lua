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
        player:setPos(0, -3, -8, 60)
    end

    local zoreRespawn = GetMobByID(ID.mob.ZOREDONITE):getLocalVar('respawn')
    local zoneWindow = GetMobByID(ID.mob.ZOREDONITE):getLocalVar('zoneWindow')

    -- If Zoredonite respawn is up, 30% chance to spawn
    if
        os.time() > zoreRespawn and
        os.time() > zoneWindow and
        math.random(1, 10) > 7
    then
        GetMobByID(ID.mob.ZOREDONITE):setRespawnTime(math.random(120, 480))
    end

    if os.time() > zoneWindow then
        -- Block multiple spawn chance rolls per boat ride
        GetMobByID(ID.mob.ZOREDONITE):setLocalVar('zoneWindow', os.time() + 20)
    end

    return cs
end

zoneObject.onTransportEvent = function(player, transport)
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
