-----------------------------------
-- ID: 15261
-- Item: hydra_tiara
-- Item Effect: Crit Rate +7% **Needs validation**
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.POTENCY)
    if effect ~= nil and effect:getSubType() == 15261 then
        target:delStatusEffect(xi.effect.POTENCY)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.POTENCY, 7, 0, 180, 15261)
end

return item_object
