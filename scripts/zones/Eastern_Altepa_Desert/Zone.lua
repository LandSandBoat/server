-----------------------------------
--
-- Zone: Eastern_Altepa_Desert (114)
--
-----------------------------------
local ID = require("scripts/zones/Eastern_Altepa_Desert/IDs")
require("scripts/globals/icanheararainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/chocobo")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.NANDI)
    GetMobByID(ID.mob.NANDI):setRespawnTime(math.random(3600, 4200))

    UpdateNMSpawnPoint(ID.mob.CACTROT_RAPIDO)
    GetMobByID(ID.mob.CACTROT_RAPIDO):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.CENTURIO_XII_I)
    GetMobByID(ID.mob.CENTURIO_XII_I):setRespawnTime(math.random(900, 10800))

    tpz.conq.setRegionalConquestOverseers(zone:getRegionID())
    tpz.chocobo.initZone(zone)
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onZoneIn(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos( 260.09, 6.013, 320.454, 76)
    end

    if triggerLightCutscene(player) then -- Quest: I Can Hear A Rainbow
        cs = 2
    end

    return cs
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
    if csid == 2 then
        lightCutsceneUpdate(player) -- Quest: I Can Hear A Rainbow
    end
end

function onEventFinish(player, csid, option)
    if csid == 2 then
        lightCutsceneFinish(player) -- Quest: I Can Hear A Rainbow
    end
end
