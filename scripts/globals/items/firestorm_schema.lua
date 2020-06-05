-----------------------------------------
-- ID: 6049
-- Firestorm Schema
-- Teaches the white magic Firestorm
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(115)
end

function onItemUse(target)
    target:addSpell(115)
end
