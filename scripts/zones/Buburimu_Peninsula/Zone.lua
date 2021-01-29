-----------------------------------
--
-- Zone: Buburimu_Peninsula (118)
--
-----------------------------------
local ID = require("scripts/zones/Buburimu_Peninsula/IDs")
require("scripts/quests/i_can_hear_a_rainbow")
require("scripts/globals/chocobo_digging")
require("scripts/globals/conquest")
require("scripts/globals/helm")
require("scripts/globals/zone")
-----------------------------------
local zone_object = {}

zone_object.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zone_object.onInitialize = function(zone)
    local hour = VanadielHour()

    if hour >= 6 and hour < 16 then
        GetMobByID(ID.mob.BACKOO):setRespawnTime(1)
    end

    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helm.type.LOGGING)
end

zone_object.onZoneIn = function(player, prevZone)
    local cs = -1

    if player:getXPos() == 0 and player:getYPos() == 0 and player:getZPos() == 0 then
        player:setPos( -276.529, 16.403, -324.519, 14)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 3
    elseif player:getCurrentMission(WINDURST) == xi.mission.id.windurst.VAIN and player:getMissionStatus(player:getNation()) ==1 then
        cs = 5 -- zone 4 buburimu no update (north)
    end

    return cs
end

zone_object.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zone_object.onRegionEnter = function(player, region)
end

zone_object.onGameHour = function(zone)
    local hour = VanadielHour()
    local nmBackoo = GetMobByID(ID.mob.BACKOO)

    if hour == 6 then -- backoo time-of-day pop condition open
        DisallowRespawn(ID.mob.BACKOO, false)
        if nmBackoo:getRespawnTime() == 0 then
            nmBackoo:setRespawnTime(1)
        end
    elseif hour == 16 then -- backoo despawns
        DisallowRespawn(ID.mob.BACKOO, true)
        if nmBackoo:isSpawned() then
            nmBackoo:spawn(1)
        end
    end
end


zone_object.onEventUpdate = function( player, csid, option)
    if csid == 3 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 5 then
        if player:getPreviousZone() == xi.zone.LABYRINTH_OF_ONZOZO or player:getPreviousZone() == xi.zone.MHAURA then
            player:updateEvent(0, 0, 0, 0, 0, 7)
        elseif player:getPreviousZone() == xi.zone.MAZE_OF_SHAKHRAMI then
            player:updateEvent(0, 0, 0, 0, 0, 6)
        end
    end
end

zone_object.onEventFinish = function( player, csid, option)
end

return zone_object
