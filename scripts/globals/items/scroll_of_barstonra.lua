-----------------------------------------
-- ID: 4677
-- Scroll of Barstonra
-- Teaches the white magic Barstonra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(69)
end

function onItemUse(target)
    target:addSpell(69)
end
