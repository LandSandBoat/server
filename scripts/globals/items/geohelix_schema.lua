-----------------------------------------
-- ID: 6045
-- Geohelix Schema
-- Teaches the black magic Geohelix
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(278)
end

function onItemUse(target)
    target:addSpell(278)
end
