-----------------------------------
-- ID: 14787
-- Item: Deadeye Earring
-- Item Effect: Ranged Attack 20
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.DEADEYE_EARRING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.DEADEYE_EARRING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.DEADEYE_EARRING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.DEADEYE_EARRING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.RATT, 20)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.RATT, 20)
end

return itemObject
