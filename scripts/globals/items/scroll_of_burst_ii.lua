-----------------------------------------
-- ID: 4821
-- Scroll of Burst II
-- Teaches the black magic Burst II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(213)
end

function onItemUse(target)
    target:addSpell(213)
end
