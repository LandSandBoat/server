-----------------------------------------
-- ID: 4750
-- Scroll of Reraise III
-- Teaches the white magic Reraise III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(142)
end

function onItemUse(target)
    target:addSpell(142)
end
