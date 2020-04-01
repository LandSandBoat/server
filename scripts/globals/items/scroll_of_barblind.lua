-----------------------------------------
-- ID: 4683
-- Scroll of Barblind
-- Teaches the white magic Barblind
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(75)
end

function onItemUse(target)
    target:addSpell(75)
end
