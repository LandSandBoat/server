-----------------------------------
-- ID: 15862
-- Item: enthralling_brocade_obi
-- Item Effect: CHR+10
-- Duration: 3 Minutes
-----------------------------------
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    if target:getStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ENTHRALLING_BROCADE_OBI) ~= nil then
        target:delStatusEffect(xi.effect.ENCHANTMENT, nil, xi.items.ENTHRALLING_BROCADE_OBI)
    end

    return 0
end

itemObject.onItemUse = function(target)
    if target:hasEquipped(xi.items.ENTHRALLING_BROCADE_OBI) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 60, 0, 0, 0, xi.items.ENTHRALLING_BROCADE_OBI)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.CHR, 10)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.CHR, 10)
end

return itemObject
