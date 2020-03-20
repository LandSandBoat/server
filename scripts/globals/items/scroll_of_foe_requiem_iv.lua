-----------------------------------------
-- ID: 4979
-- Scroll of Foe Requiem IV
-- Teaches the song Foe Requiem IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(371)
end

function onItemUse(target)
    target:addSpell(371)
end
