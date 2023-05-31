-----------------------------------
-- Zone: Carpenters_Landing (2)
-----------------------------------
local func = require('scripts/zones/Carpenters_Landing/globals')
local ID = require('scripts/zones/Carpenters_Landing/IDs')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/helm')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.TEMPEST_TIGON)
    GetMobByID(ID.mob.TEMPEST_TIGON):setRespawnTime(math.random(900, 10800))

    xi.helm.initZone(zone, xi.helm.type.LOGGING)
    func.herculesTreeOnGameHour()
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(6.509, -9.163, -819.333, 239)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onGameHour = function(zone)
    local hour = VanadielHour()

    if hour == 7 or hour == 22 then
        func.herculesTreeOnGameHour()
    end
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
end

return zoneObject
