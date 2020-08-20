-----------------------------------
--
-- Zone: Batallia_Downs (105)
--
-----------------------------------
local ID = require("scripts/zones/Batallia_Downs/IDs")
require("scripts/globals/icanheararainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/missions")
require("scripts/globals/zone")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.AHTU)
    GetMobByID(ID.mob.AHTU):setRespawnTime(math.random(900, 10800))
end

function onZoneIn( player, prevZone)
    local cs = -1

    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos( -693.609, -14.583, 173.59, 30)
    end

    if (triggerLightCutscene(player)) then -- Quest: I Can Hear A Rainbow
        cs = 901
    elseif (player:getCurrentMission(WINDURST) == tpz.mission.id.windurst.VAIN and player:getCharVar("MissionStatus") ==1) then
        cs = 903
    end

    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onRegionEnter( player, region)
end

function onEventUpdate( player, csid, option)
    if (csid == 901) then
        lightCutsceneUpdate(player) -- Quest: I Can Hear A Rainbow
    end
end

function onEventFinish( player, csid, option)
    if (csid == 901) then
        lightCutsceneFinish(player) -- Quest: I Can Hear A Rainbow
    elseif (csid == 903) then
        if (player:getZPos() >  -331) then
            player:updateEvent(0, 0, 0, 0, 0, 3)
        else
            player:updateEvent(0, 0, 0, 0, 0, 2)
        end
    end
end
