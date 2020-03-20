-----------------------------------------
-- ID: 5075
-- Scroll of Raptor Mazurka
-- Teaches the song Raptor Mazurka
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(467)
end

function onItemUse(target)
    target:addSpell(467)
end
