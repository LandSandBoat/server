-----------------------------------------
-- ID: 4928
-- Scroll of Katon: Ichi
-- Teaches the ninjutsu Katon: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(320)
end

function onItemUse(target)
    target:addSpell(320)
end
