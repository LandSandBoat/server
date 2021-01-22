-----------------------------------
-- ID: 11403
-- Item: Talaria
-- Enchantment: Increases movement speed.
-- Durration: 60 Mins
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    if (target:hasStatusEffect(tpz.effect.ENCHANTMENT) == false) then
        target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 3600, 11403)
    end
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.MOVE, 15)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.MOVE, 15)
end

return item_object
