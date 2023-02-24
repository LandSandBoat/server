-----------------------------------
-- ID: 18241
-- Item: Vial of Refresh Musk
-- Item Effect: 60 seconds
-- Duration: 30 Seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.REFRESH)
    if
        effect ~= nil and
        effect:getItemSourceID() == xi.items.VIAL_OF_REFRESH_MUSK
    then
        target:delStatusEffect(xi.effect.REFRESH)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.REFRESH, 3, 3, 60, 0, 0, 0, xi.items.VIAL_OF_REFRESH_MUSK)
end

return itemObject
