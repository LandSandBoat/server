-----------------------------------------
-- ID: 5093
-- Scroll of Gain-CHR
-- Teaches the white magic Gain-CHR
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(492)
end

function onItemUse(target)
    target:addSpell(492)
end
