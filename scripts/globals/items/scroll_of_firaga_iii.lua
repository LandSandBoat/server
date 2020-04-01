-----------------------------------------
-- ID: 4784
-- Scroll of Firaga III
-- Teaches the black magic Firaga III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(176)
end

function onItemUse(target)
    target:addSpell(176)
end
