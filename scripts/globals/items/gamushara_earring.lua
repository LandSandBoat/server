-----------------------------------
-- ID: 14788
-- Item: Gamushara Earring
-- Item Effect: Attack +22
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.GAMUSHARA_EARRING) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.GAMUSHARA_EARRING)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.GAMUSHARA_EARRING) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.GAMUSHARA_EARRING)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ATT, 22)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ATT, 22)
end

return itemObject
