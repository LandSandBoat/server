-----------------------------------
-- ID: 14541
-- Item: taikyoku_kenpogi
-- Item Effect: Eva +3
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.EVASION_BOOST)
    if effect ~= nil and effect:getSubType() == 14541 then
        target:delStatusEffect(xi.effect.EVASION_BOOST)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.EVASION_BOOST, 3, 0, 1800, 14541)
end

return item_object
