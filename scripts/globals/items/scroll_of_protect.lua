-----------------------------------------
-- ID: 4651
-- Scroll of Protect
-- Teaches the white magic Protect
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(43)
end

function onItemUse(target)
    target:addSpell(43)
end
