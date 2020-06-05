-----------------------------------------
-- ID: 4967
-- Scroll of Yurin: Ichi
-- Teaches the ninjutsu Yurin: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(508)
end

function onItemUse(target)
    target:addSpell(508)
end
