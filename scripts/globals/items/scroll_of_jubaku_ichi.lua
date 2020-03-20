-----------------------------------------
-- ID: 4949
-- Scroll of Jubaku: Ichi
-- Teaches the ninjutsu Jubaku: Ichi
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(341)
end

function onItemUse(target)
    target:addSpell(341)
end
