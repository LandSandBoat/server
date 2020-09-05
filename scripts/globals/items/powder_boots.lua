-----------------------------------------
-- ID: 15320
-- Powder Boots
--  Enchantment: "Flee"
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:delStatusEffect(tpz.effect.FLEE)
    target:addStatusEffect(tpz.effect.FLEE, 100, 0, 30)
end
