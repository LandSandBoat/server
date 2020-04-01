-----------------------------------------
-- ID: 5003
-- Scroll of Valor Minuet II
-- Teaches the song Valor Minuet II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(395)
end

function onItemUse(target)
    target:addSpell(395)
end
