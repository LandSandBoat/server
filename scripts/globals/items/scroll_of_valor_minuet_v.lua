-----------------------------------------
-- ID: 5006
-- Scroll of Valor Minuet V
-- Teaches the song Valor Minuet V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(398)
end

function onItemUse(target)
    target:addSpell(398)
end
