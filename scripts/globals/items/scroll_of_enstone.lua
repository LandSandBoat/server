-----------------------------------------
-- ID: 4711
-- Scroll of Enstone
-- Teaches the white magic Enstone
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(103)
end

function onItemUse(target)
    target:addSpell(103)
end
