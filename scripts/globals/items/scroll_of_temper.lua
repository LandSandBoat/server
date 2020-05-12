-----------------------------------------
-- ID: 4705
-- Scroll of Temper
-- Teaches the white magic Temper
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(493)
end

function onItemUse(target)
    target:addSpell(493)
end
