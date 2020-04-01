-----------------------------------------
-- ID: 4956
-- Scroll of Kurayami: Ni
-- Teaches the ninjutsu Kurayami: Ni
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(348)
end

function onItemUse(target)
    target:addSpell(348)
end
