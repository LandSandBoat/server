-----------------------------------------
-- ID: 4614
-- Scroll of Cure VI
-- Teaches the white magic Cure VI
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(6)
end

function onItemUse(target)
    target:addSpell(6)
end
