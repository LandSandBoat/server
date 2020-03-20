-----------------------------------------
-- ID: 4952
-- Scroll of Hojo: Ichi
-- Teaches the ninjutsu Hojo: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(344)
end

function onItemUse(target)
    target:addSpell(344)
end
