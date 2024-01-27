-----------------------------------
-- Zone: Uleguerand_Range (5)
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.JORMUNGAND)
    GetMobByID(ID.mob.JORMUNGAND):setRespawnTime(math.random(86400, 259200))

    -- ffxiclopedia's pages for Black Coney and White Coney say 7 and 5 Earth seconds respectively, in game it is very fast
    -- https://ffxiclopedia.fandom.com/wiki/Black_Coney
    -- https://ffxiclopedia.fandom.com/wiki/White_Coney
    -- BG Wiki has no info. For now, triggers every 3 vana minutes
    GetNPCByID(ID.npc.RABBIT_FOOTPRINT):addPeriodicTrigger(0, 3, 0)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(363.025, 16, -60, 12)
    end

    if
        player:getCurrentMission(xi.mission.log_id.COP) == xi.mission.id.cop.DAWN and
        player:getCharVar('COP_louverance_story') == 1
    then
        cs = 17
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 17 then
        player:setCharVar('COP_louverance_story', 2)
    end
end

zoneObject.onZoneWeatherChange = function(weather)
    local waterfall = GetNPCByID(ID.npc.WATERFALL)

    if weather == xi.weather.SNOW or weather == xi.weather.BLIZZARDS then
        if waterfall:getAnimation() ~= xi.anim.CLOSE_DOOR then
            waterfall:setAnimation(xi.anim.CLOSE_DOOR)
        end
    else
        if waterfall:getAnimation() ~= xi.anim.OPEN_DOOR then
            waterfall:setAnimation(xi.anim.OPEN_DOOR)
        end
    end
end

return zoneObject
