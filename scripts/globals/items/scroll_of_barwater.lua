-----------------------------------------
-- ID: 4673
-- Scroll of Barwater
-- Teaches the white magic Barwater
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(65)
end

function onItemUse(target)
    target:addSpell(65)
end
