-----------------------------------
-- ID: 18242
-- Item: Wyvern Feed
-- Item Effect: Pet Regen
-- Duration 3 Minutes
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local pet = target:getPet()
    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    elseif target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.BAG_OF_WYVERN_FEED) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.BAG_OF_WYVERN_FEED)
    end

    return 0
end

itemObject.onItemUse = function(target)
    local pet = target:getPet()
    if target:hasEquipped(xi.items.BAG_OF_WYVERN_FEED) and pet ~= nil then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 180, 0, 0, 0, xi.items.BAG_OF_WYVERN_FEED)
    end
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
