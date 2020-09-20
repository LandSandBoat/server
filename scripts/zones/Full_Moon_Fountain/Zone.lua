-----------------------------------
--
-- Zone: Full_Moon_Fountain (170)
--
-----------------------------------
local ID = require("scripts/zones/Full_Moon_Fountain/IDs")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/settings")
require("scripts/globals/titles")
-----------------------------------

function onInitialize(zone)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-260.136, 2.09, -325.702, 188)
    end
    if player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.FULL_MOON_FOUNTAIN and player:getCharVar("MissionStatus") == 3 then
        cs = 50
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.DOLL_OF_THE_DEAD and player:getCharVar("MissionStatus") == 7 then
        cs = 61
    end
    return cs
end

function afterZoneIn(player)
    player:entityVisualPacket("kilk")
    player:entityVisualPacket("izum")
    player:entityVisualPacket("hast")
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 50 then
        finishMissionTimeline(player, 3, csid, option)
    elseif csid == 61 then
        player:addTitle(tpz.title.GUIDING_STAR)
        finishMissionTimeline(player, 3, csid, option)
    elseif csid == 32004 then
        local battlefield = player:getBattlefield()
        if battlefield then
            local inst = battlefield:getArea()
            local instOffset = ID.mob.MOON_READING_OFFSET + (6 * (inst - 1))
            local allyPos =
            {
                [1] = { ajidoPos = {340.117,   48.752, -383.747, 64}, playerPos = { 340.220,  48.557, -386.114, 190} },
                [2] = { ajidoPos = { -59.98,   10.752,    16.22, 64}, playerPos = { -59.877,  10.577,   13.853, 190} },
                [3] = { ajidoPos = {-379.826, -51.248,  376.227, 64}, playerPos = {-459.974, -51.423,   373.86, 190} },
            }

            -- spawn Yali and Yatzlwurm
            for i = instOffset + 4, instOffset + 5 do
                SpawnMob(i)
            end

            -- spawn Ajido-Marujido and set ally positions
            local allies = battlefield:getAllies()
            if #allies == 0 then
                local ajido = battlefield:insertEntity(14184, true, true)
                ajido:setSpawn(allyPos[inst].ajidoPos)
                ajido:spawn()
            end
            player:setPos(allyPos[inst].playerPos)
        end
    end
end
