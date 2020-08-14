-----------------------------------------
-- ID: 4629
-- Scroll of Holy II
-- Teaches the white magic Holy II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(22)
end

function onItemUse(target)
    target:addSpell(22)
end
