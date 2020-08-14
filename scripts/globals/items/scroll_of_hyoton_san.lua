-----------------------------------------
-- ID: 4932
-- Scroll of Hyoton: San
-- Teaches the ninjutsu Hyoton: San
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(325)
end

function onItemUse(target)
    target:addSpell(325)
end
