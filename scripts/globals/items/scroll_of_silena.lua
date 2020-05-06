-----------------------------------------
-- ID: 4625
-- Scroll of Silena
-- Teaches the white magic Silena
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(17)
end

function onItemUse(target)
    target:addSpell(17)
end
