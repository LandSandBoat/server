-----------------------------------------
-- ID: 4892
-- Scroll of Aeroja
-- Teaches the black magic Aeroja
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(498)
end

function onItemUse(target)
    target:addSpell(498)
end
