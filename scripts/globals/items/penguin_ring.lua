-----------------------------------------
-- ID: 15553 and 15556
-- Item: penguin ring
-- Increases skill at tiring fish
-----------------------------------------
-- Bonus: The effect of the ring dramatically increases the rate of stamina drain of a fish while you try to reel it in.
-- Duration: 20:00 min
-----------------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local result = 0
    if target:getMod(xi.mod.PENGUIN_RING_EFFECT) ~= 0 then
        result = xi.msg.basic.ITEM_UNABLE_TO_USE_2
    end

    return result
end

itemObject.onItemUse = function(target)
    target:addStatusEffectEx(xi.effect.NA, xi.effect.ENCHANTMENT, 0, 3, 1200)
    target:addMod(xi.mod.PENGUIN_RING_EFFECT, 1200)
end

return itemObject
