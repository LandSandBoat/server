-----------------------------------
-- Zone: Yuhtunga_Jungle (123)
-----------------------------------
local ID = require('scripts/zones/Yuhtunga_Jungle/IDs')
require('scripts/quests/i_can_hear_a_rainbow')
require('scripts/globals/chocobo_digging')
require('scripts/globals/conquest')
require('scripts/globals/helm')
require('scripts/globals/zone')
require('scripts/globals/beastmentreasure')
require('scripts/missions/amk/helpers')
-----------------------------------
local zoneObject = {}

zoneObject.onChocoboDig = function(player, precheck)
    return xi.chocoboDig.start(player, precheck)
end

zoneObject.onInitialize = function(zone)
    xi.conq.setRegionalConquestOverseers(zone:getRegionID())

    xi.helm.initZone(zone, xi.helm.type.HARVESTING)
    xi.helm.initZone(zone, xi.helm.type.LOGGING)

    xi.bmt.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zoneObject.onGameDay = function()
    xi.bmt.updatePeddlestox(xi.zone.YUHTUNGA_JUNGLE, ID.npc.PEDDLESTOX)
end

zoneObject.onConquestUpdate = function(zone, updatetype)
    xi.conq.onConquestUpdate(zone, updatetype)
end

zoneObject.onZoneIn = function(player, prevZone)
    local cs = -1

    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        player:setPos(116.825, 6.613, 100, 140)
    end

    if quests.rainbow.onZoneIn(player) then
        cs = 11
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
    if csid == 11 then
        quests.rainbow.onEventUpdate(player)
    end
end

zoneObject.onEventFinish = function(player, csid, option, npc)
end

return zoneObject
