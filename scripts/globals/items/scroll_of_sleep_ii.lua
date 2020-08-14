-----------------------------------------
-- ID: 4867
-- Scroll of Sleep II
-- Teaches the black magic Sleep II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(259)
end

function onItemUse(target)
    target:addSpell(259)
end
