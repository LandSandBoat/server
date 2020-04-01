-----------------------------------------
-- ID: 4965
-- Scroll of Aisha: Ichi
-- Teaches the ninjutsu Aisha: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(319)
end

function onItemUse(target)
    target:addSpell(319)
end
