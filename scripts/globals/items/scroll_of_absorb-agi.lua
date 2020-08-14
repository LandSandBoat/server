-----------------------------------------
-- ID: 4877
-- Scroll of Absorb-AGI
-- Teaches the black magic Absorb-AGI
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(269)
end

function onItemUse(target)
    target:addSpell(269)
end
