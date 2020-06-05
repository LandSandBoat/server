-----------------------------------------
-- ID: 4815
-- Scroll of Freeze II
-- Teaches the black magic Freeze II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(207)
end

function onItemUse(target)
    target:addSpell(207)
end
