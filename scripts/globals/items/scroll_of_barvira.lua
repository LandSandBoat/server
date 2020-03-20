-----------------------------------------
-- ID: 4700
-- Scroll of Barvira
-- Teaches the white magic Barvira
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(92)
end

function onItemUse(target)
    target:addSpell(92)
end
