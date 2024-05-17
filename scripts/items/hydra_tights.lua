-----------------------------------
-- ID: 15596
-- Item: Hydra Tights
-- Item Effect: 10% haste, stacks with haste
-- Notes: must remain equipped to keep the effect, overwrites existing haste enchantment
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

    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.HASTE, 0, 0, 180, item:getID())
end

itemObject.onItemUnequip = function(user, item)
    local effect = user:getItemEnchantmentEffect(item:getID())
    if effect then
        effect:delStatusEffect()
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.HASTE_MAGIC, 1000)
end

return itemObject
