-----------------------------------
-- ID: 15862
-- Item: enthralling_brocade_obi
-- Item Effect: CHR+10
-- Duration: 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15862 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end

    return 0
end

itemObject.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 15862)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CHR, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CHR, 10)
end

return itemObject
