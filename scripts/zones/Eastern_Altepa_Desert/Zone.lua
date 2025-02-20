-----------------------------------
-- Zone: Eastern_Altepa_Desert (114)
-----------------------------------
local ID = zones[xi.zone.EASTERN_ALTEPA_DESERT]
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.NANDI)
    GetMobByID(ID.mob.NANDI):setRespawnTime(math.random(3600, 4200))

    UpdateNMSpawnPoint(ID.mob.CACTROT_RAPIDO)
    GetMobByID(ID.mob.CACTROT_RAPIDO):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.CENTURIO_XII_I)
    GetMobByID(ID.mob.CENTURIO_XII_I):setRespawnTime(math.random(900, 10800))

    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())
    xi.chocobo.initZone(zone)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(260.09, 6.013, 320.454, 76)
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

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 2 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
