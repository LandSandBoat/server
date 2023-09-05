-----------------------------------------
-- ID: 15552 and 15555
-- Item: albatross ring
-- Fishing Stamina Bonus
-----------------------------------------
-- Bonus: +30s to Fishing Stamina
-- Duration: 20:00 min
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getMod(xi.mod.ALBATROSS_RING_EFFECT) == 1 then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.ENCHANTMENT, xi.effect.ENCHANTMENT, 0, 3, 1200, 15552)
end

itemObject.onEffectGain = function(target, effect)
    target:addMod(xi.mod.ALBATROSS_RING_EFFECT, 1200)
end

itemObject.onEffectLose = function(target, effect)
    target:delMod(xi.mod.ALBATROSS_RING_EFFECT, 1200)
end

return itemObject
