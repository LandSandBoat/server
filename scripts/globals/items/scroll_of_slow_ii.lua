-----------------------------------------
-- ID: 6569
-- Scroll of Slow II
-- Teaches the white magic Slow II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(79)
end

function onItemUse(target)
    target:addSpell(79)
end
