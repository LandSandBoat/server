-----------------------------------------
-- ID: 4976
-- Scroll of Foe Requiem
-- Teaches the song Foe Requiem
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(368)
end

function onItemUse(target)
    target:addSpell(368)
end
