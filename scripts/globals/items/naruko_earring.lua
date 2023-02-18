-----------------------------------
-- ID: 14789
-- Item: Naruko Earring
-- Item Effect: Enmity +10
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENMITY_BOOST)
    if effect ~= nil and effect:getItemSourceID() == 14789 then
        target:delStatusEffect(xi.effect.ENMITY_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENMITY_BOOST, 10, 0, 180, 0, 0, 0, 14789)
end

return itemObject
