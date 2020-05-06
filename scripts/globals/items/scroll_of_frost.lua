-----------------------------------------
-- ID: 4844
-- Scroll of Frost
-- Teaches the black magic Frost
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(236)
end

function onItemUse(target)
    target:addSpell(236)
end
