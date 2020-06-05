-----------------------------------------
-- ID: 4714
-- Scroll of Phalanx
-- Teaches the white magic Phalanx
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(106)
end

function onItemUse(target)
    target:addSpell(106)
end
