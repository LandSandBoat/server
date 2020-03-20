-----------------------------------------
-- ID: 4652
-- Scroll of Protect II
-- Teaches the white magic Protect II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(44)
end

function onItemUse(target)
    target:addSpell(44)
end
