-----------------------------------
--
-- Zone: Caedarva_Mire (79)
--
-----------------------------------
local ID = require("scripts/zones/Caedarva_Mire/IDs")
require("scripts/globals/missions")
require("scripts/globals/titles")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.AYNU_KAYSEY)
    GetMobByID(ID.mob.AYNU_KAYSEY):setRespawnTime(math.random(900, 10800))
    GetMobByID(ID.mob.KHIMAIRA):setRespawnTime(math.random(12, 36)*3600) -- 12 to 36 hours after maintenance, in 1-hour increments

    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(339.996, 2.5, -721.286, 200)
    end
    if prevZone == tpz.zone.LEUJAOAM_SANCTUM then
        player:setPos(495.450, -28.25, -478.43, 32)
    end
    if prevZone == tpz.zone.PERIQIA then
        player:setPos(-252.715, -7.666, -30.64, 128)
    end

    if (player:getCurrentMission(TOAU) == tpz.mission.id.toau.SHADES_OF_VENGEANCE and player:getCharVar("AhtUrganStatus") == 1) then
        cs = 21
    end

    return cs
end

function afterZoneIn(player)
    player:entityVisualPacket("1pb1")
    player:entityVisualPacket("2pb1")
    player:entityVisualPacket("1pd1")
    player:entityVisualPacket("2pc1")
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)

    if csid == 21 then
        player:completeMission(TOAU, tpz.mission.id.toau.SHADES_OF_VENGEANCE)
        player:setCharVar("AhtUrganStatus", 0)
        player:setCharVar("TOAUM31_PERMITDAY", 0)
        player:setTitle(tpz.title.NASHMEIRAS_MERCENARY)
        player:addMission(TOAU, tpz.mission.id.toau.IN_THE_BLOOD)
    elseif csid == 133 then -- enter instance, warp to periqia
        player:setPos(0, 0, 0, 0, 56)
    elseif csid == 130 then
        player:setPos(0, 0, 0, 0, 69)
    end
end
