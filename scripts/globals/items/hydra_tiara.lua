-----------------------------------
-- ID: 15261
-- Item: hydra_tiara
-- Item Effect: Crit Rate +7% **Needs validation**
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.POTENCY)
    if effect ~= nil and effect:getItemSourceID() == 15261 then
        target:delStatusEffect(xi.effect.POTENCY)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.POTENCY, 7, 0, 180, 0, 0, 0, 15261)
end

return itemObject
