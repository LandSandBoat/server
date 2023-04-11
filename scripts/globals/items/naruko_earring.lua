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
    if effect ~= nil and effect:getItemSourceID() == xi.items.NARUKO_EARRING then
        target:delStatusEffect(xi.effect.ENMITY_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.NARUKO_EARRING) then
        target:addStatusEffect(xi.effect.ENMITY_BOOST, 10, 0, 180, 0, 0, 0, xi.items.NARUKO_EARRING)
    end
end

return itemObject
