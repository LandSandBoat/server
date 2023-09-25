-----------------------------------
-- Zone: Windurst_Waters (238)
-----------------------------------
local ID = require('scripts/zones/Windurst_Waters/IDs')
require('scripts/globals/events/harvest_festivals')
require('scripts/globals/events/starlight_celebrations')
require('scripts/globals/events/sunbreeze_festival')
require('scripts/globals/conquest')
require('scripts/globals/cutscenes')
require('scripts/globals/zone')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
    -- Used for Windurst Mission 1-3
    zone:registerTriggerArea(1, 23, -12, -208, 31, -8, -197)

    applyHalloweenNpcCostumes(zone:getID())
    xi.events.starlightCelebration.applyStarlightDecorations(zone:getID())
end

zoneObject.onZoneIn = function(player, prevZone)
    -- MOG HOUSE EXIT
    if
        player:getXPos() == 0 and
        player:getYPos() == 0 and
        player:getZPos() == 0
    then
        local position = math.random(1, 5) + 157
        player:setPos(position, -5, -62, 192)
    end

    xi.moghouse.exitJobChange(player, prevZone)
end

zoneObject.afterZoneIn = function(player)
    xi.moghouse.afterZoneIn(player)
end

zoneObject.onConquestUpdate = function(zone, updatetype, influence, owner, ranking, isConquestAlliance)
    xi.conq.onConquestUpdate(zone, updatetype, influence, owner, ranking, isConquestAlliance)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    xi.moghouse.exitJobChangeFinish(player, csid, option)
end

zoneObject.onGameHour = function(zone)
    xi.events.sunbreeze_festival.spawnFireworks(zone)
end

return zoneObject
