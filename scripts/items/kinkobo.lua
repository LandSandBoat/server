-----------------------------------
-- ID: 17592
-- Item: Kinkobo
-- Enchantment: Subtle Blow
-- Duration: 60 Mins
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.ENCHANTMENT) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 3600, origin = user, subType = 17592 })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.SUBTLE_BLOW, 20)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
