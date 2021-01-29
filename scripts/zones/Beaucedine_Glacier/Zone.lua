-----------------------------------
--
-- Zone: Beaucedine_Glacier (111)
--
-----------------------------------
local ID = require("scripts/zones/Beaucedine_Glacier/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/missions")
require("scripts/globals/conquest")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.HUMBABA)
    GetMobByID(ID.mob.HUMBABA):setRespawnTime(math.random(3600, 4200))

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if prevZone == xi.zone.DYNAMIS_BEAUCEDINE then -- warp player to a correct position after dynamis
        player:setPos(-284.751, -39.923, -422.948, 235)
    end

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-247.911, -82.165, 260.207, 248)
    end

    if player:getCurrentMission(COP) == xi.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") ==
        9 then
        cs = 206
    elseif quests.rainbow.onZoneIn(player) then
        cs = 114
    elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getMissionStatus(player:getNation()) ==
        1 then
        cs = 116
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onEventUpdate = function(player, csid, option)
    if csid == 114 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 116 then
        player:updateEvent(0, 0, 0, 0, 0, 4)
    elseif csid == 206 then
        player:updateEvent(0, xi.ki.MYSTERIOUS_AMULET)
    end
end

zone_object.onEventFinish = function(player, csid, option)
    if csid == 206 then
        player:setCharVar("PromathiaStatus", 10)
    end
end

zone_object.onZoneWeatherChange = function(weather)
    local mirrorPond = GetNPCByID(ID.npc.MIRROR_POND_J8) -- Quest: Love And Ice

    if weather ~= xi.weather.SNOW and weather ~= xi.weather.BLIZZARDS then
        mirrorPond:setStatus(xi.status.NORMAL)
    else
        mirrorPond:setStatus(xi.status.DISAPPEAR)
    end
end

return zone_object
