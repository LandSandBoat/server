-----------------------------------------
-- ID: 4766
-- Scroll of Aero V
-- Teaches the black magic Aero V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(158)
end

function onItemUse(target)
    target:addSpell(158)
end
