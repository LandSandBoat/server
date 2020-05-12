-----------------------------------------
-- ID: 4833
-- Scroll of Poisonga
-- Teaches the black magic Poisonga
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(225)
end

function onItemUse(target)
    target:addSpell(225)
end
