-----------------------------------------
-- ID: 4934
-- Scroll of Huton: Ichi
-- Teaches the ninjutsu Huton: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(326)
end

function onItemUse(target)
    target:addSpell(326)
end
