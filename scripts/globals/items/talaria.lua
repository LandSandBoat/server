-----------------------------------
-- ID: 11403
-- Item: Talaria
-- Enchantment: Increases movement speed.
-- Durration: 60 Mins
-----------------------------------
require("scripts/globals/settings")
require("scripts/globals/status")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.ENCHANTMENT) then
        target:addStatusEffect(xi.effect.ENCHANTMENT, 0, 0, 3600, 11403)
    end
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.MOVE, 15)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.MOVE, 15)
end

return itemObject
