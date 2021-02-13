-----------------------------------
-- ID: 15611
-- Item: sturdy_slacks
-- Item Effect: HP +7, MP +7
-- Duration: 30 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(tpz.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15611 then
        target:delStatusEffect(tpz.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(tpz.effect.ENCHANTMENT, 0, 0, 1800, 15611)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(tpz.mod.HP, 7)
    target:addMod(tpz.mod.MP, 7)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(tpz.mod.HP, 7)
    target:delMod(tpz.mod.MP, 7)
end

return item_object
