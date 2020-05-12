-----------------------------------------
-- ID: 4955
-- Scroll of Kurayami: Ichi
-- Teaches the ninjutsu Kurayami: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(347)
end

function onItemUse(target)
    target:addSpell(347)
end
