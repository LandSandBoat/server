-----------------------------------------
-- ID: 4620
-- Scroll of Raise
-- Teaches the white magic Raise
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(12)
end

function onItemUse(target)
    target:addSpell(12)
end
