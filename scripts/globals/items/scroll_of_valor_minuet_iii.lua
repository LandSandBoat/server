-----------------------------------------
-- ID: 5004
-- Scroll of Valor Minuet III
-- Teaches the song Valor Minuet III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(396)
end

function onItemUse(target)
    target:addSpell(396)
end
