-----------------------------------------
-- ID: 4971
-- Scroll of Yain: Ichi
-- Teaches the ninjutsu Yain: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(506)
end

function onItemUse(target)
    target:addSpell(506)
end
