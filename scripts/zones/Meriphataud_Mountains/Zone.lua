-----------------------------------
-- Zone: Meriphataud_Mountains (119)
-----------------------------------
local ID = zones[xi.zone.MERIPHATAUD_MOUNTAINS]
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.WARAXE_BEAK)
    GetMobByID(ID.mob.WARAXE_BEAK):setRespawnTime(math.random(900, 10800))

    UpdateNMSpawnPoint(ID.mob.COO_KEJA_THE_UNSEEN)
    GetMobByID(ID.mob.COO_KEJA_THE_UNSEEN):setRespawnTime(math.random(900, 10800))

    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(752.632, -33.761, -40.035, 129)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 31
    end

    -- AMK06/AMK07
    if xi.settings.main.ENABLE_AMK == 1 then
        xi.amk.helpers.tryRandomlyPlaceDiggingLocation(player)
    end

    return cs
end

zoneObject.afterZoneIn = function(player)
    xi.chocoboGame.handleMessage(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conquest.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 31 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
