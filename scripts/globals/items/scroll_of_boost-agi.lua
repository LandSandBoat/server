-----------------------------------------
-- ID: 5097
-- Scroll of Boost-AGI
-- Teaches the white magic Boost-AGI
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(482)
end

function onItemUse(target)
    target:addSpell(482)
end
