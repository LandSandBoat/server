-----------------------------------------
-- ID: 4695
-- Scroll of Barpoisonra
-- Teaches the white magic Barpoisonra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(87)
end

function onItemUse(target)
    target:addSpell(87)
end
