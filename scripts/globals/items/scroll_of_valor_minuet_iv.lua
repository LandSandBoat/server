-----------------------------------------
-- ID: 5005
-- Scroll of Valor Minuet IV
-- Teaches the song Valor Minuet IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(397)
end

function onItemUse(target)
    target:addSpell(397)
end
