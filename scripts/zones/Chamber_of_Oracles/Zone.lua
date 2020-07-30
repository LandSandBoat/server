-----------------------------------
--
-- Zone: Chamber_of_Oracles (168)
--
-----------------------------------
local ID = require("scripts/zones/Chamber_of_Oracles/IDs")
require("scripts/globals/conquest")
require("scripts/globals/keyitems")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local CurrentMission = player:getCurrentMission(WINDURST)
    local MissionStatus = player:getCharVar("MissionStatus")
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(-177.804, -2.765, -37.893, 179)
    end

    if (prevZone == tpz.zone.QUICKSAND_CAVES and CurrentMission == tpz.mission.id.windurst.MOON_READING and MissionStatus >= 1) then
        cs = 3
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
    if (csid == 3) then
        player:addKeyItem(tpz.ki.ANCIENT_VERSE_OF_ALTEPA)
        player:messageSpecial(ID.text.KEYITEM_OBTAINED, tpz.ki.ANCIENT_VERSE_OF_ALTEPA)
    end
end
