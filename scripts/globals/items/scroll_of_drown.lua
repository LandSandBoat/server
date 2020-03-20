-----------------------------------------
-- ID: 4848
-- Scroll of Drown
-- Teaches the black magic Drown
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(240)
end

function onItemUse(target)
    target:addSpell(240)
end
