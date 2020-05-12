-----------------------------------------
-- ID: 5039
-- Scroll of Herculean Etude
-- Teaches the song Herculean Etude
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(431)
end

function onItemUse(target)
    target:addSpell(431)
end
