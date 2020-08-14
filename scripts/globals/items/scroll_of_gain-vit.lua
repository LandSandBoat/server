-----------------------------------------
-- ID: 5089
-- Scroll of Gain-VIT
-- Teaches the white magic Gain-VIT
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(488)
end

function onItemUse(target)
    target:addSpell(488)
end
