-----------------------------------------
-- ID: 4747
-- Scroll of Teleport-Vahzl
-- Teaches the white magic Teleport-Vahzl
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(139)
end

function onItemUse(target)
    target:addSpell(139)
end
