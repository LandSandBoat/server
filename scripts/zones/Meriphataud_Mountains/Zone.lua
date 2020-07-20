-----------------------------------
--
-- Zone: Meriphataud_Mountains (119)
--
-----------------------------------
local ID = require("scripts/zones/Meriphataud_Mountains/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.WARAXE_BEAK)
    GetMobByID(ID.mob.WARAXE_BEAK):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.COO_KEJA_THE_UNSEEN)
    GetMobByID(ID.mob.COO_KEJA_THE_UNSEEN):setRespawnTime(math.random(900, 10800))

    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos(752.632, -33.761, -40.035, 129)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 31
    elseif player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") == 1 then
        cs = 34 -- no update for castle oztroja (north)
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if csid == 31 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 34 then
        if player:getPreviousZone() == tpz.zone.SAUROMUGUE_CHAMPAIGN then
            player:updateEvent(0, 0, 0, 0, 0, 2)
        elseif player:getPreviousZone() == tpz.zone.TAHRONGI_CANYON then
            player:updateEvent(0, 0, 0, 0, 0, 1)
        end
    end
end

function onEventFinish(player, csid, option)
end
