-----------------------------------------
-- ID: 4969
-- Scroll of Migawari: Ichi
-- Teaches the ninjutsu Migawari: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(510)
end

function onItemUse(target)
    target:addSpell(510)
end
