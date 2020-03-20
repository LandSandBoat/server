-----------------------------------------
-- ID: 4715
-- Scroll of Reprisal
-- Teaches the white magic Reprisal
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(97)
end

function onItemUse(target)
    target:addSpell(97)
end
