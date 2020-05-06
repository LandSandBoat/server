-----------------------------------------
-- ID: 4707
-- Scroll of Endark
-- Teaches the white magic Endark
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(311)
end

function onItemUse(target)
    target:addSpell(311)
end
