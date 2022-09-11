-----------------------------------------
-- ID: 15462
-- Item: Talisman Obi
-- Effect: 3Min, MP+12 Enmity-2
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect and effect:getSubType() == 15881 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 1800, 15881)
end

item_object.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MP, 12)
    target:addMod(xi.mod.ENMITY, -2)
end

item_object.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MP, 12)
    target:delMod(xi.mod.ENMITY, -2)
end

return item_object
