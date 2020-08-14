-----------------------------------------
-- ID: 6041
-- Pyrohelix Schema
-- Teaches the black magic Pyrohelix
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(281)
end

function onItemUse(target)
    target:addSpell(281)
end
