-----------------------------------
--
-- Zone: North_Gustaberg (106)
--
-----------------------------------
local ID = require("scripts/zones/North_Gustaberg/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(-518.867, 35.538, 588.64, 50)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 244
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 246
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if csid == 244 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 246 then
        if player:getZPos() > 461 then
            player:updateEvent(0, 0, 0, 0, 0, 6)
        elseif player:getXPos() > -240 then
            player:updateEvent(0, 0, 0, 0, 0, 7)
        end
    end
end

function onEventFinish(player, csid, option)
end
