-----------------------------------------
-- ID: 4685
-- Scroll of Barpetrify
-- Teaches the white magic Barpetrify
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(77)
end

function onItemUse(target)
    target:addSpell(77)
end
