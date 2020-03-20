-----------------------------------------
-- ID: 6051
-- Thunderstorm Schema
-- Teaches the white magic Thunderstorm
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(117)
end

function onItemUse(target)
    target:addSpell(117)
end
