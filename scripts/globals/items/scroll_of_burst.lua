-----------------------------------------
-- ID: 4820
-- Scroll of Burst
-- Teaches the black magic Burst
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(212)
end

function onItemUse(target)
    target:addSpell(212)
end
