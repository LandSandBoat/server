-----------------------------------------
-- ID: 5071
-- Scroll of Foe Lullaby
-- Teaches the song Foe Lullaby
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(463)
end

function onItemUse(target)
    target:addSpell(463)
end
