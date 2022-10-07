-----------------------------------
-- ID: 14785
-- Item: Janizary Earring
-- Item Effect: Defence +32
-- Duration 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.DEFENSE_BOOST)
    if effect ~= nil and effect:getSubType() == 14785 then
        target:delStatusEffect(xi.effect.DEFENSE_BOOST)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.DEFENSE_BOOST, 32, 0, 180, 14785)
end

return item_object
