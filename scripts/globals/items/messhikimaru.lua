-----------------------------------
-- ID: 17826
-- Item: Messhikimaru
-- Enchantment: Arcana Killer
-- Durration: 10 Mins
-----------------------------------
require("scripts/settings/main")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (target:hasStatusEffect(xi.effect.ENCHANTMENT) == false) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 600, 17826)
    end
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ARCANA_KILLER, 20)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ARCANA_KILLER, 20)
end

return item_object
