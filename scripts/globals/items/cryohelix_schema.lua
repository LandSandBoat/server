-----------------------------------------
-- ID: 6044
-- Cryohelix Schema
-- Teaches the black magic Cryohelix
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(282)
end

function onItemUse(target)
    target:addSpell(282)
end
