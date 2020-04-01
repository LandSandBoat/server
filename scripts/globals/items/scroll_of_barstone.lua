-----------------------------------------
-- ID: 4671
-- Scroll of Barstone
-- Teaches the white magic Barstone
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(63)
end

function onItemUse(target)
    target:addSpell(63)
end
