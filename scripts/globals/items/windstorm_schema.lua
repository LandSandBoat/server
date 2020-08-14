-----------------------------------------
-- ID: 6054
-- Windstorm Schema
-- Teaches the white magic Windstorm
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(114)
end

function onItemUse(target)
    target:addSpell(114)
end
