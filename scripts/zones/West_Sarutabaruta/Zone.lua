-----------------------------------
-- Zone: West_Sarutabaruta (115)
-----------------------------------
local ID = require('scripts/zones/West_Sarutabaruta/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/missions')
require('scripts/globals/helm')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
    xi.voidwalker.zoneOnInit(zone)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(320.018, -6.684, -45.166, 189)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 48
    elseif
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.BURGEONING_DREAD and
        prevZone == xi.zone.WINDURST_WATERS
    then
        cs = 62
    elseif
        player:getCurrentMission(xi.mission.log_id.ASA) == xi.mission.id.asa.BURGEONING_DREAD and
        prevZone == xi.zone.PORT_WINDURST
    then
        cs = 63
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
    SetServerVariable("[DIG]ZONE115_ITEMS", 0)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option, npc)
    if csid == 48 then
        quests.rainbow.onEventUpdate(player)
    elseif csid == 62 or csid == 63 then
        player:setCharVar("ASA_Status", option)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
    if csid == 62 or csid == 63 then
        player:completeMission(xi.mission.log_id.ASA, xi.mission.id.asa.BURGEONING_DREAD)
        player:addMission(xi.mission.log_id.ASA, xi.mission.id.asa.THAT_WHICH_CURDLES_BLOOD)
    end
end

return zoneObject
