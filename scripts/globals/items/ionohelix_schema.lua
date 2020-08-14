-----------------------------------------
-- ID: 6043
-- Ionohelix Schema
-- Teaches the black magic Ionohelix
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(283)
end

function onItemUse(target)
    target:addSpell(283)
end
