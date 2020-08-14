-----------------------------------------
-- ID: 4617
-- Scroll of Curaga III
-- Teaches the white magic Curaga III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(9)
end

function onItemUse(target)
    target:addSpell(9)
end
