-----------------------------------
-- ID: 17826
-- Item: Messhikimaru
-- Enchantment: Arcana Killer
-- Durration: 10 Mins
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.MESSHIKIMARU) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 600, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.MESSHIKIMARU })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.ARCANA_KILLER, 20)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
