-----------------------------------------
-- ID: 5002
-- Scroll of Valor Minuet
-- Teaches the song Valor Minuet
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(394)
end

function onItemUse(target)
    target:addSpell(394)
end
