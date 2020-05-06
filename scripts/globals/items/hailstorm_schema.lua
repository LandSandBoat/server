-----------------------------------------
-- ID: 6052
-- Hailstorm Schema
-- Teaches the white magic Hailstorm
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(116)
end

function onItemUse(target)
    target:addSpell(116)
end
