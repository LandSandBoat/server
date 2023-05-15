-----------------------------------
-- ID: 4181
-- Scroll of Instant Warp
-- Transports the user to their Home Point
-----------------------------------
require("scripts/globals/teleports")
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getZoneID() == 131 then
        return xi.msg.basic.CANT_BE_USED_IN_AREA
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.TELEPORT, 0, xi.teleport.id.WARP, 0, 1)
end

return itemObject
