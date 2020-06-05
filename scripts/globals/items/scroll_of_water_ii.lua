-----------------------------------------
-- ID: 4778
-- Scroll of Water II
-- Teaches the black magic Water II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(170)
end

function onItemUse(target)
    target:addSpell(170)
end
