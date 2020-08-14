-----------------------------------------
-- ID: 5091
-- Scroll of Gain-INT
-- Teaches the white magic Gain-INT
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(490)
end

function onItemUse(target)
    target:addSpell(490)
end
