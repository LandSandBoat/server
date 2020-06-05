-----------------------------------------
-- ID: 4794
-- Scroll of Aeroga III
-- Teaches the black magic Aeroga III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(186)
end

function onItemUse(target)
    target:addSpell(186)
end
