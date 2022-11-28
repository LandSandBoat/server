-----------------------------------
-- ID: 18029
-- Item: piercing_dagger
-- Item Effect: Attack +3
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ATTACK_BOOST)
    if effect ~= nil and effect:getSubType() == 18029 then
        target:delStatusEffect(xi.effect.ATTACK_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ATTACK_BOOST, 3, 0, 1800, 18029)
end

return itemObject
