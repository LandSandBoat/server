-----------------------------------------
-- ID: 5070
-- Scroll of Magic Finale
-- Teaches the song Magic Finale
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(462)
end

function onItemUse(target)
    target:addSpell(462)
end
