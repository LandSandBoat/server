-----------------------------------------
-- ID: 4817
-- Scroll of Tornado II
-- Teaches the black magic Tornado II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(209)
end

function onItemUse(target)
    target:addSpell(209)
end
