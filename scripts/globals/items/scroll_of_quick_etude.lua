-----------------------------------------
-- ID: 5035
-- Scroll of Quick Etude
-- Teaches the song Quick Etude
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(427)
end

function onItemUse(target)
    target:addSpell(427)
end
