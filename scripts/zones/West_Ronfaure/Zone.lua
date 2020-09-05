-----------------------------------
--
-- Zone: West_Ronfaure (100)
--
-----------------------------------
local ID = require("scripts/zones/West_Ronfaure/IDs")
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
        player:setPos(-24.427, -53.107, 140, 127)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 51
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 53
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if csid == 51 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 53 then
        player:updateEvent(0, 0, 0, 0, 0, 5)
    end
end

function onEventFinish(player, csid, option)
end
