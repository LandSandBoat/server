-----------------------------------
-- ID: 18242
-- Item: Wyvern Feed
-- Item Effect: Pet Regen
-- Duration 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target, user, item, param)
    local pet = target:getPet()
    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    end

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
    local pet = target:getPet()
    pet:addMod(xi.mod.REGEN, 3)
end

itemObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if pet ~= nil then
        pet:delMod(xi.mod.REGEN, 3)
    end
end

return itemObject
