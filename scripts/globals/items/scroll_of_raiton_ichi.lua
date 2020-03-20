-----------------------------------------
-- ID: 4940
-- Scroll of Raiton: Ichi
-- Teaches the ninjutsu Raiton: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(332)
end

function onItemUse(target)
    target:addSpell(332)
end
