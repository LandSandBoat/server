-----------------------------------------
-- ID: 4608, 4609
-- Scroll of Cure
-- Teaches the white magic Cure
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(1)
end

function onItemUse(target)
    target:addSpell(1)
end
