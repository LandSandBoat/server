-----------------------------------------
-- ID: 4792
-- Scroll of Aeroga
-- Teaches the black magic Aeroga
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(184)
end

function onItemUse(target)
    target:addSpell(184)
end
