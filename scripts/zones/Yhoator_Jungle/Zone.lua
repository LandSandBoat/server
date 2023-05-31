-----------------------------------
-- Zone: Yhoator_Jungle (124)
-----------------------------------
local ID = require('scripts/zones/Yhoator_Jungle/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/chocobo')
require('scripts/globals/helm')
require('scripts/globals/zone')
require('scripts/globals/beastmentreasure')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

local function updateRainHarvesting(status)
    for point = 1, #ID.npc.HARVESTING do
        GetNPCByID(ID.npc.HARVESTING[point]):setStatus(status)
    end
end

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    -- NM Persistence
    xi.mob.nmTODPersistCache(zone, ID.mob.WOODLAND_SAGE)
    xi.mob.nmTODPersistCache(zone, ID.mob.BRIGHT_HANDED_KUNBERRY)

    if xi.settings.main.ENABLE_WOTG == 1 then
        xi.mob.nmTODPersistCache(zone, ID.mob.POWDERER_PENNY)
    end

    UpdateNMSpawnPoint(ID.mob.BISQUE_HEELED_SUNBERRY)
    UpdateNMSpawnPoint(ID.mob.BRIGHT_HANDED_KUNBERRY)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.chocobo.initZone(zone)
    xi.helm.initZone(zone, xi.helm.type.LOGGING)
    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
    updateRainHarvesting(xi.status.DISAPPEAR)

    xi.bmt.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zoneObject.onGameDay = function()
    xi.bmt.updatePeddlestox(xi.zone.YHOATOR_JUNGLE, ID.npc.PEDDLESTOX)

    -- Chocobo Digging.
    SetServerVariable("[DIG]ZONE124_ITEMS", 0)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneWeatherChange = function(weatherType)
    if weatherType == xi.weather.RAIN or weatherType == xi.weather.SQUALL then
        updateRainHarvesting(xi.status.NORMAL)
    else
        updateRainHarvesting(xi.status.DISAPPEAR)
    end
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(299.997, -5.838, -622.998, 190)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 2
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onZoneOut = function(player)
    if player:hasStatusEffect(xi.effect.BATTLEFIELD) then
        player:delStatusEffect(xi.effect.BATTLEFIELD)
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
