-----------------------------------------
-- ID: 4981
-- Scroll of Foe Requiem VI
-- Teaches the song Foe Requiem VI
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(373)
end

function onItemUse(target)
    target:addSpell(373)
end
