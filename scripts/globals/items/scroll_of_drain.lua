-----------------------------------------
-- ID: 4853
-- Scroll of Drain
-- Teaches the black magic Drain
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(245)
end

function onItemUse(target)
    target:addSpell(245)
end
