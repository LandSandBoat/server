-----------------------------------------
-- ID: 4611
-- Scroll of Cure III
-- Teaches the white magic Cure III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(3)
end

function onItemUse(target)
    target:addSpell(3)
end
