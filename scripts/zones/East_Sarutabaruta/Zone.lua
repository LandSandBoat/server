-----------------------------------
--
-- Zone: East_Sarutabaruta (116)
--
-----------------------------------
local ID = require("scripts/zones/East_Sarutabaruta/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.DUKE_DECAPOD)
    GetMobByID(ID.mob.DUKE_DECAPOD):setRespawnTime(math.random(3600, 4200))
end

function onZoneIn(player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(305.377, -36.092, 660.435, 71)
    end

    -- Check if we are on Windurst Mission 1-2
    if (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.THE_HEART_OF_THE_MATTER and
        player:getCharVar("MissionStatus") == 5 and prevZone == tpz.zone.OUTER_HORUTOTO_RUINS) then
        cs = 48;
    elseif quests.rainbow.onZoneIn(player) then
        cs = 50;
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==
        1) then
        cs = 52 -- go north no parameters (0 = north NE 1 E 2 SE 3 S 4 SW 5 W6 NW 7 @ as the 6th parameter)
    elseif (player:getCurrentMission(ASA) == tpz.mission.id.asa.BURGEONING_DREAD and prevZone == tpz.zone.WINDURST_WOODS and
        player:hasStatusEffect(tpz.effect.MOUNTED) == false) then
        cs = 71
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if (csid == 50) then
        quests.rainbow.onEventUpdate(player)
    elseif (csid == 52) then
        if (player:getPreviousZone() == tpz.zone.WINDURST_WOODS or player:getPreviousZone() ==
            tpz.zone.WEST_SARUTABARUTA) then
            if (player:getZPos() < 570) then
                player:updateEvent(0, 0, 0, 0, 0, 1)
            else
                player:updateEvent(0, 0, 0, 0, 0, 2)
            end
        elseif (player:getPreviousZone() == tpz.zone.OUTER_HORUTOTO_RUINS) then
            if (player:getZPos() > 570) then
                player:updateEvent(0, 0, 0, 0, 0, 2)
            end
        end
    elseif (csid == 71) then
        player:setCharVar("ASA_Status", option)
    end
end

function onEventFinish(player, csid, option)
    if (csid == 48) then
        player:setCharVar("MissionStatus", 6)
        -- Remove the glowing orb key items
        player:delKeyItem(tpz.ki.FIRST_GLOWING_MANA_ORB);
        player:delKeyItem(tpz.ki.SECOND_GLOWING_MANA_ORB);
        player:delKeyItem(tpz.ki.THIRD_GLOWING_MANA_ORB);
        player:delKeyItem(tpz.ki.FOURTH_GLOWING_MANA_ORB);
        player:delKeyItem(tpz.ki.FIFTH_GLOWING_MANA_ORB);
        player:delKeyItem(tpz.ki.SIXTH_GLOWING_MANA_ORB);
    elseif (csid == 71) then
        player:completeMission(ASA, tpz.mission.id.asa.BURGEONING_DREAD)
        player:addMission(tpz.mission.log_id.ASA, tpz.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
    end
end
