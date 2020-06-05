-----------------------------------------
-- ID: 4746
-- Scroll of Deodorize
-- Teaches the white magic Deodorize
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(138)
end

function onItemUse(target)
    target:addSpell(138)
end
