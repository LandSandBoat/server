-----------------------------------------
-- ID: 6050
-- Rainstorm Schema
-- Teaches the white magic Rainstorm
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(113)
end

function onItemUse(target)
    target:addSpell(113)
end
