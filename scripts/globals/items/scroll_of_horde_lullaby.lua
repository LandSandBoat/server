-----------------------------------------
-- ID: 4984
-- Scroll of Horde Lullaby
-- Teaches the song Horde Lullaby
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(376)
end

function onItemUse(target)
    target:addSpell(376)
end
