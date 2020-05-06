-----------------------------------------
-- ID: 4840
-- Scroll of Bio III
-- Teaches the black magic Bio III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(232)
end

function onItemUse(target)
    target:addSpell(232)
end
