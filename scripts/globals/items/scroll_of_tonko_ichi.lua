-----------------------------------------
-- ID: 4961
-- Scroll of Tonko: Ichi
-- Teaches the ninjutsu Tonko: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(353)
end

function onItemUse(target)
    target:addSpell(353)
end
