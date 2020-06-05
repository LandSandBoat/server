-----------------------------------------
-- ID: 4664
-- Scroll of Slow
-- Teaches the white magic Slow
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(56)
end

function onItemUse(target)
    target:addSpell(56)
end
