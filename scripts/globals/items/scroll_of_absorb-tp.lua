-----------------------------------------
-- ID: 4883
-- Scroll of Absorb-TP
-- Teaches the black magic Absorb-TP
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(275)
end

function onItemUse(target)
    target:addSpell(275)
end
