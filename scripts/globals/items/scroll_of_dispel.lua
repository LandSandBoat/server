-----------------------------------------
-- ID: 4868
-- Scroll of Dispel
-- Teaches the black magic Dispel
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(260)
end

function onItemUse(target)
    target:addSpell(260)
end
