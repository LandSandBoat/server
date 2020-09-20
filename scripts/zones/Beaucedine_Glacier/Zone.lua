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

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.HUMBABA)
    GetMobByID(ID.mob.HUMBABA):setRespawnTime(math.random(3600, 4200))

    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())
end

function onZoneIn(player, prevZone)
    local cs = -1

    if prevZone == tpz.zone.DYNAMIS_BEAUCEDINE then -- warp player to a correct position after dynamis
        player:setPos(-284.751, -39.923, -422.948, 235)
    end

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-247.911, -82.165, 260.207, 248)
    end

    if player:getCurrentMission(COP) == tpz.mission.id.cop.DESIRES_OF_EMPTINESS and player:getCharVar("PromathiaStatus") ==
        9 then
        cs = 206
    elseif quests.rainbow.onZoneIn(player) then
        cs = 114
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==
        1 then
        cs = 116
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if csid == 114 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 116 then
        player:updateEvent(0, 0, 0, 0, 0, 4)
    end
end

function onEventFinish(player, csid, option)
    if csid == 206 then
        player:setCharVar("PromathiaStatus", 10)
    end
end

function onZoneWeatherChange(weather)
    local mirrorPond = GetNPCByID(ID.npc.MIRROR_POND_J8) -- Quest: Love And Ice

    if weather ~= tpz.weather.SNOW and weather ~= tpz.weather.BLIZZARDS then
        mirrorPond:setStatus(tpz.status.NORMAL)
    else
        mirrorPond:setStatus(tpz.status.DISAPPEAR)
    end
end
