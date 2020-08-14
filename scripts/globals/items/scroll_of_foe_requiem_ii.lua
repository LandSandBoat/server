-----------------------------------------
-- ID: 4977
-- Scroll of Foe Requiem II
-- Teaches the song Foe Requiem II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(369)
end

function onItemUse(target)
    target:addSpell(369)
end
