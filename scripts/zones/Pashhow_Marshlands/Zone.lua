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
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.BOWHO_WARMONGER)

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

zoneObject.onZoneOut = function(player)
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        player:delStatusEffect(xi.effect.BATTLEFIELD)
    end
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onGameDay = function()
    SetServerVariable("[DIG]ZONE109_ITEMS", 0)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 13 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

zoneObject.onZoneWeatherChange = function(weather)
    if xi.settings.main.ENABLE_WOTG == 1 then
        if weather == xi.weather.RAIN or weather == xi.weather.SQUALL then
            DisallowRespawn(ID.mob.TOXIC_TAMLYN, false)
            if
                os.time() > GetServerVariable("TamlynRespawn") and
                not GetMobByID(ID.mob.TOXIC_TAMLYN):isSpawned()
            then
                SpawnMob(ID.mob.TOXIC_TAMLYN)
            end
        elseif weather ~= xi.weather.RAIN or weather ~= xi.weather.SQUALL then
            DisallowRespawn(ID.mob.TOXIC_TAMLYN, true)
        end
    end
end

return zoneObject
