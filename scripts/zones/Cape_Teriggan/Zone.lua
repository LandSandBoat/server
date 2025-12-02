-----------------------------------
-- Zone: Cape_Teriggan (113)
-----------------------------------
local ID = zones[xi.zone.CAPE_TERIGGAN]
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-219, 0, -318, 191)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onZoneWeatherChange = function(weather)
    local kreutzet = GetMobByID(ID.mob.KREUTZET)

    if kreutzet then
        if weather == xi.weather.WIND or weather == xi.weather.GALES then
            DisallowRespawn(ID.mob.KREUTZET, false)

            -- Check for respawn.
            if
                not kreutzet:isSpawned() and
                kreutzet:getRespawnTime() == 0
            then
                kreutzet:setRespawnTime(math.random(30, 150)) -- pop 30-150 sec after wind weather starts
            end
        else
            DisallowRespawn(ID.mob.KREUTZET, true) -- Disallow respawn.
        end
    end
end

return zoneObject
