-----------------------------------------
-- ID: 4728
-- Scroll of Teleport-Yhoat
-- Teaches the white magic Teleport-Yhoat
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(120)
end

function onItemUse(target)
    target:addSpell(120)
end
