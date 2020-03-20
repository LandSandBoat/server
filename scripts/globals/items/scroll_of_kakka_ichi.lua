-----------------------------------------
-- ID: 4968
-- Scroll of Kakka: Ichi
-- Teaches the ninjutsu Kakka: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(509)
end

function onItemUse(target)
    target:addSpell(509)
end
