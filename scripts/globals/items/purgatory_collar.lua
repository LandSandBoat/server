-----------------------------------
-- ID: 15507
-- Item: Purgatory Collar
-- Item Effect: Conserve MP
-- Duration: 45 seconds
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    local effect = target:getStatusEffect(xi.effect.ENCHANTMENT)
    if effect ~= nil and effect:getSubType() == 15507 then
        target:delStatusEffect(xi.effect.ENCHANTMENT)
    end
    return 0
end

item_object.onItemUse = function(target)
    target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 45, 15507)
end

item_object.onEffectGain = function(target)
    -- **Power needs validation**
    target:addMod(xi.mod.CONSERVE_MP, 10)
end

item_object.onEffectLose = function(target)
    target:delMod(xi.mod.CONSERVE_MP, 10)
end

return item_object
