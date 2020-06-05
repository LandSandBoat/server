-----------------------------------------
-- ID: 4935
-- Scroll of Huton: Ni
-- Teaches the ninjutsu Huton: Ni
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(327)
end

function onItemUse(target)
    target:addSpell(327)
end
