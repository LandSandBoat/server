-----------------------------------
-- ID: 14531
-- Item: bannaret_mail
-- Item Effect: HP +15, Enmity +2
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.BANNARET_MAIL) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.BANNARET_MAIL)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.BANNARET_MAIL) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 0, 0, 0, xi.items.BANNARET_MAIL)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.HP, 15)
    target:addMod(xi.mod.ENMITY, 2)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.HP, 15)
    target:delMod(xi.mod.ENMITY, 2)
end

return itemObject
