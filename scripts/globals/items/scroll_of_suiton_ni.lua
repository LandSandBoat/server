-----------------------------------------
-- ID: 4944
-- Scroll of Suiton: Ni
-- Teaches the ninjutsu Suiton: Ni
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(336)
end

function onItemUse(target)
    target:addSpell(336)
end
