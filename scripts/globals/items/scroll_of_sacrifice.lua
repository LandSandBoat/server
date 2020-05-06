-----------------------------------------
-- ID: 4702
-- Scroll of Sacrifice
-- Teaches the white magic Sacrifice
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(94)
end

function onItemUse(target)
    target:addSpell(94)
end
