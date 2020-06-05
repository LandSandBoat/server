-----------------------------------------
-- ID: 4669
-- Scroll of Barblizzard
-- Teaches the white magic Barblizzard
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(61)
end

function onItemUse(target)
    target:addSpell(61)
end
