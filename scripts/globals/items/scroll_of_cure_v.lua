-----------------------------------------
-- ID: 4613
-- Scroll of Cure V
-- Teaches the white magic Cure V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(5)
end

function onItemUse(target)
    target:addSpell(5)
end
