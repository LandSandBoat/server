-----------------------------------
-- ID: 18243
-- Item: Astral Pot
-- Item Effect: Pet Magical Attack +10
-- Duration: 3 Minutes
-- https://wiki.ffo.jp/html/10083.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    local pet = target:getPet()
    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    local pet = target:getPet()
    if not pet then
        return
    end

    if target:hasEquipped(xi.item.ASTRAL_POT) then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ASTRAL_POT)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.ASTRAL_POT })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    local pet = target:getPet()
    if not pet then
        return
    end

    pet:addMod(xi.mod.MATT, 10)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.ASTRAL_POT)
end

itemObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if not pet then
        return
    end

    pet:delMod(xi.mod.MATT, 10)
end

return itemObject
