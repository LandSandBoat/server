-----------------------------------
-- Zone: Pashhow_Marshlands (109)
-----------------------------------
local ID = require('scripts/zones/Pashhow_Marshlands/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/zone')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.BOWHO_WARMONGER)
    GetMobByID(ID.mob.BOWHO_WARMONGER):setRespawnTime(75600 + math.random(600, 900)) -- 21 hours, plus 10 to 15 min

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(547.841, 23.192, 696.323, 136)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 13
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onZoneWeatherChange = function(weather)
    local toxicTamlyn = GetMobByID(ID.mob.TOXIC_TAMLYN)
    local currentTime = os.time()

    if toxicTamlyn:isSpawned() then
        if
            weather ~= xi.weather.RAIN and
            weather ~= xi.weather.SQUALL
        then
            DespawnMob(ID.mob.TOXIC_TAMLYN)
            toxicTamlyn:setLocalVar("spawnTime", currentTime + 3600) -- 1 hour
        end
    else
        if
            (weather == xi.weather.RAIN or weather == xi.weather.SQUALL) and
            toxicTamlyn:getLocalVar("spawnTime") < currentTime
        then
            SpawnMob(ID.mob.TOXIC_TAMLYN)
        end
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 13 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
