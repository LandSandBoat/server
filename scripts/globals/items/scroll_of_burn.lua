-----------------------------------------
-- ID: 4843
-- Scroll of Burn
-- Teaches the black magic Burn
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(235)
end

function onItemUse(target)
    target:addSpell(235)
end
