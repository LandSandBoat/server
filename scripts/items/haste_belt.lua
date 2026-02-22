-----------------------------------
-- ID: 15290
-- Item: Haste Belt
-- Item Effect: 10% haste
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUnequip = function(target, item)
    target:delStatusEffect(xi.effect.HASTE, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.HASTE_BELT)
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.HASTE_BELT) then
        -- TODO: Haste applied by the belt should a separate buff from Spell Haste and stacks. Currently overwrites.
        target:addStatusEffect(xi.effect.HASTE, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.HASTE_BELT })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.HASTE_MAGIC, 1000)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
