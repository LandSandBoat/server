-----------------------------------
-- ID: 18067
-- Equip: Keen Zaghnal
--  Enchantment: Accuracy +3
-- Enchantment will wear off if weapon is unequipped.
--  Effect lasts for 30 minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ACCURACY_BOOST)
    if effect ~= nil and effect:getItemSourceID() == xi.items.KEEN_ZAGHNAL then
        target:delStatusEffect(xi.effect.ACCURACY_BOOST)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.KEEN_ZAGHNAL) then
        target:addStatusEffect(xi.effect.ACCURACY_BOOST, 3, 0, 1800, 0, 0, 0, xi.items.KEEN_ZAGHNAL)
    end
end

return itemObject
