-----------------------------------------
-- ID: 6571
-- Scroll of Phalanx II
-- Teaches the white magic Phalanx II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(107)
end

function onItemUse(target)
    target:addSpell(107)
end
