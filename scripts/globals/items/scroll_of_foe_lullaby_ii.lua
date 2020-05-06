-----------------------------------------
-- ID: 5079
-- Scroll of Foe Lullaby II
-- Teaches the song Foe Lullaby II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(471)
end

function onItemUse(target)
    target:addSpell(471)
end
