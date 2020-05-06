-----------------------------------------
-- ID: 6042
-- Hydrohelix Schema
-- Teaches the black magic Hydrohelix
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(279)
end

function onItemUse(target)
    target:addSpell(279)
end
