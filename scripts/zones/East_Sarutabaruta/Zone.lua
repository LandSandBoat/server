-----------------------------------
-- Zone: East_Sarutabaruta (116)
-----------------------------------
local ID = require('scripts/zones/East_Sarutabaruta/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/keyitems')
require('scripts/globals/missions')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    UpdateNMSpawnPoint(ID.mob.DUKE_DECAPOD)
    GetMobByID(ID.mob.DUKE_DECAPOD):setRespawnTime(math.random(3600, 4200))
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(-125, -3, -519, 4)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 50
    elseif
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.BURGEONING_DREAD and
        prevZone == xi.zone.WINDURST_WOODS and
        not player:hasStatusEffect(xi.effect.MOUNTED)
    then
        cs = 71
    end

    return cs
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
    if csid == 50 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 71 then
        player:setCharVar("ASA_Status", option)
    end
end

zoneObject.onEventFinish = function(player, csid, option)
    if csid == 71 then
        player:completeMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
    end
end

return zoneObject
