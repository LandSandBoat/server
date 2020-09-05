-----------------------------------
--
-- Zone: Carpenters_Landing (2)
--
-----------------------------------
local func = require("scripts/zones/Carpenters_Landing/globals")
local ID = require("scripts/zones/Carpenters_Landing/IDs")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/helm")
-----------------------------------

function onChocoboDig(player, precheck)
    return tpz.chocoboDig.start(player, precheck)
end

function onInitialize(zone)
    UpdateNMSpawnPoint(ID.mob.TEMPEST_TIGON)
    GetMobByID(ID.mob.TEMPEST_TIGON):setRespawnTime(math.random(900, 10800))

    tpz.helm.initZone(zone, tpz.helm.type.LOGGING)
    func.herculesTreeOnGameHour()
end

function onZoneIn(player, prevZone)
    local cs = -1
    if (player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0) then
        player:setPos(6.509, -9.163, -819.333, 239)
    end
    return cs
end

function onConquestUpdate(zone, updatetype)
    tpz.conq.onConquestUpdate(zone, updatetype)
end

function onGameHour(zone)
    local hour = VanadielHour()

    if hour == 7 or hour == 22 then
        func.herculesTreeOnGameHour()
    end
end

function onRegionEnter(player, region)
end

function onEventUpdate(player, csid, option)
end

function onEventFinish(player, csid, option)
end
