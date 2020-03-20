-----------------------------------------
-- ID: 5073
-- Scroll of Chocobo Mazurka
-- Teaches the song Chocobo Mazurka
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(465)
end

function onItemUse(target)
    target:addSpell(465)
end
