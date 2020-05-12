-----------------------------------------
-- ID: 4931
-- Scroll of Hyoton: Ichi
-- Teaches the ninjutsu Hyoton: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(323)
end

function onItemUse(target)
    target:addSpell(323)
end
