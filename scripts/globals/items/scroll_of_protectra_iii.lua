-----------------------------------------
-- ID: 4735
-- Scroll of Protectra III
-- Teaches the white magic Protectra III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(127)
end

function onItemUse(target)
    target:addSpell(127)
end
