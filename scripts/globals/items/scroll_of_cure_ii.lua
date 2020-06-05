-----------------------------------------
-- ID: 4610
-- Scroll of Cure II
-- Teaches the white magic Cure II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(2)
end

function onItemUse(target)
    target:addSpell(2)
end
