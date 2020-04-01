-----------------------------------------
-- ID: 4739
-- Scroll of Shellra II
-- Teaches the white magic Shellra II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(131)
end

function onItemUse(target)
    target:addSpell(131)
end
