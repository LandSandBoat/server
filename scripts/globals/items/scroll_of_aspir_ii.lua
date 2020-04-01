-----------------------------------------
-- ID: 4856
-- Scroll of Aspir II
-- Teaches the black magic Aspir II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(248)
end

function onItemUse(target)
    target:addSpell(248)
end
