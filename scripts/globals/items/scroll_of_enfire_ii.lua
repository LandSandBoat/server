-----------------------------------------
-- ID: 4722
-- Scroll of Enfire II
-- Teaches the white magic Enfire II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(312)
end

function onItemUse(target)
    target:addSpell(312)
end
