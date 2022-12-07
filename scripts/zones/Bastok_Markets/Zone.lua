-----------------------------------
-- Zone: Bastok_Markets (235)
-----------------------------------
require('scripts/globals/events/harvest_festivals')
require('scripts/globals/events/starlight_celebrations')
require('scripts/globals/cutscenes')
require('scripts/globals/settings')
require('scripts/globals/zone')
local ID = require('scripts/zones/Bastok_Markets/IDs')
-----------------------------------
local zoneObject = {}

zoneObject.onInitialize = function(zone)
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
        local position = math.random(1, 5) - 33
        player:setPos(-177, -8, position, 127)
    end

    xi.moghouse.exitJobChange(player, prevZone)
end

zoneObject.onConquestUpdate = function(zone,  updatetype)
    xi.conq.onConquestUpdate(zone,  updatetype)
end

zoneObject.onTriggerAreaEnter = function(player, triggerArea)
end

zoneObject.onGameDay = function()
    -- Removes daily the bit mask that tracks the treats traded for Harvest Festival.
    if isHalloweenEnabled() ~= 0 then
        clearVarFromAll("harvestFestTreats")
        clearVarFromAll("harvestFestTreats2")
    end
end

zoneObject.onEventUpdate = function(player, csid, option)
end

zoneObject.onEventFinish = function(player, csid, option)
    xi.moghouse.exitJobChangeFinish(player, csid, option)
end

return zoneObject
