-----------------------------------------
-- ID: 4854
-- Scroll of Drain II
-- Teaches the black magic Drain II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(246)
end

function onItemUse(target)
    target:addSpell(246)
end
