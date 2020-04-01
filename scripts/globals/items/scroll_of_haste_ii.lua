-----------------------------------------
-- ID: 4692
-- Scroll of Haste II
-- Teaches the white magic Haste II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(511)
end

function onItemUse(target)
    target:addSpell(511)
end
