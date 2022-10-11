-----------------------------------
-- ID: 18241
-- Item: Vial of Refresh Musk
-- Item Effect: 60 seconds
-- Duration: 30 Seconds
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.REFRESH)
    if effect ~= nil and effect:getSubType() == 18241 then
        target:delStatusEffect(xi.effect.REFRESH)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.REFRESH, 3, 3, 60, 18241)
end

return item_object
