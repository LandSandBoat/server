-----------------------------------------
-- ID: 4982
-- Scroll of Foe Requiem VII
-- Teaches the song Foe Requiem VII
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(374)
end

function onItemUse(target)
    target:addSpell(374)
end
