-----------------------------------------
-- ID: 4847
-- Scroll of Shock
-- Teaches the black magic Shock
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(239)
end

function onItemUse(target)
    target:addSpell(239)
end
