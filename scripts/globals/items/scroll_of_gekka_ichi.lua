-----------------------------------------
-- ID: 4970
-- Scroll of Gekka: Ichi
-- Teaches the ninjutsu Gekka: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(505)
end

function onItemUse(target)
    target:addSpell(505)
end
