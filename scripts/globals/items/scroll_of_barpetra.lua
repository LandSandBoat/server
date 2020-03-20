-----------------------------------------
-- ID: 4699
-- Scroll of Barpetra
-- Teaches the white magic Barpetra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(91)
end

function onItemUse(target)
    target:addSpell(91)
end
