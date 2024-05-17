-----------------------------------
-- ID: 15862
-- Item: enthralling_brocade_obi
-- Item Effect: CHR+10
-- Duration: 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, user, item, param)
    return 0
end

itemObject.onItemUse = function(target, user, item)
    local effect = target:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end

    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, item:getID())
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CHR, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CHR, 10)
end

return itemObject
