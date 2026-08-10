-----------------------------------
-- ID: 18242
-- Item: Wyvern Feed
-- Item Effect: Pet Regen
-- Duration: 60 Seconds
-- https://wiki.ffo.jp/html/10082.html
-- TODO: Capture Icon
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    local pet    = target:getPet()

    if not pet then
        return xi.msg.basic.REQUIRES_A_PET, 0
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    local pet = target:getPet()
    if target:hasEquipped(xi.item.BAG_OF_WYVERN_FEED) and pet then
        local effect = target:getStatusEffectBySource(xi.effect.ENCHANTMENT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.BAG_OF_WYVERN_FEED)
        if effect then
            effect:resetStartTime()
        else
            target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 60, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.BAG_OF_WYVERN_FEED })
        end
    end
end

itemObject.onEffectGain = function(target, effect)
    local pet = target:getPet()
    if not pet then
        return
    end

    pet:addMod(xi.mod.REGEN, 12)
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.BAG_OF_WYVERN_FEED)
end

itemObject.onEffectLose = function(target, effect)
    local pet = target:getPet()
    if not pet then
        return
    end

    pet:delMod(xi.mod.REGEN, 12)
end

return itemObject
