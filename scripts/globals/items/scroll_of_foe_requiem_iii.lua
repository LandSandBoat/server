-----------------------------------------
-- ID: 4978
-- Scroll of Foe Requiem III
-- Teaches the song Foe Requiem III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(370)
end

function onItemUse(target)
    target:addSpell(370)
end
