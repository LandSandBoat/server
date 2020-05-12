-----------------------------------------
-- ID: 4929
-- Scroll of Katon: Ni
-- Teaches the ninjutsu Katon: Ni
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(321)
end

function onItemUse(target)
    target:addSpell(321)
end
