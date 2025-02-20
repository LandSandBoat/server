-----------------------------------
-- Zone: Jugner_Forest (104)
-----------------------------------
local ID = zones[xi.zone.JUGNER_FOREST]
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/missions/amk/helpers')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    zone:registerCylindricalTriggerArea(1, -484, 292, 10) -- Sets Mark for "Under Oath" Quest cutscene.

    UpdateNMSpawnPoint(ID.mob.METEORMAULER)
    GetMobByID(ID.mob.METEORMAULER):setRespawnTime(math.random(900, 10800))

    local respawnTime = 900 + math.random(0, 6) * 1800 -- 0:15 to 3:15 spawn timer in 30 minute intervals
    for offset = 1, 10 do
        GetMobByID(ID.mob.KING_ARTHRO - offset):setRespawnTime(respawnTime)
    end

    xi.conquest.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helmType.LOGGING)

    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-594, -7, -442, 253)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 15
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
    if
        triggerArea:getTriggerAreaID() == 1 and
        player:getCharVar('UnderOathCS') == 7
    then
        -- Quest: Under Oath - PLD AF3
        player:startEvent(14)
    end
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 15 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 14 then
        player:setCharVar('UnderOathCS', 8) -- Quest: Under Oath - PLD AF3
    end
end

return zoneObject
