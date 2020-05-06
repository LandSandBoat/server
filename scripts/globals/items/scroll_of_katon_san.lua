-----------------------------------------
-- ID: 4930
-- Scroll of Katon: San
-- Teaches the ninjutsu Katon: San
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(322)
end

function onItemUse(target)
    target:addSpell(322)
end
