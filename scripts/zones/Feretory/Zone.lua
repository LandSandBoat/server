-----------------------------------
-- Zone: Feretory
-----------------------------------
require('scripts/globals/monstrosity')
-----------------------------------
---@type TZone
local zoneObject = {}

zoneObject.onZoneIn = function(player, prevZone)
    return xi.monstrosity.feretoryOnZoneIn(player, prevZone)
end

zoneObject.onZoneOut = function(player)
    xi.monstrosity.feretoryOnZoneOut(player)
end

return zoneObject
