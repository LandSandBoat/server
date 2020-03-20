-----------------------------------------
-- ID: 6053
-- Sandstorm Schema
-- Teaches the white magic Sandstorm
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(99)
end

function onItemUse(target)
    target:addSpell(99)
end
