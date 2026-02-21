-----------------------------------
-- ID: 11403
-- Item: Talaria
-- Enchantment: Increases movement speed.
-- Durration: 60 Mins
-- Base speed 10% or +5
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target, user)
    if not target:hasStatusEffect(xi.effect.ENCHANTMENT) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, { duration = 3600, origin = user, subType = 11403 })
    end
end

itemObject.onEffectGain = function(target, effect)
    effect:addMod(xi.mod.MOVE_SPEED_QUICKENING, 5)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
