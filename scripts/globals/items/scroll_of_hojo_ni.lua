-----------------------------------------
-- ID: 4953
-- Scroll of Hojo: Ni
-- Teaches the ninjutsu Hojo: Ni
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(345)
end

function onItemUse(target)
    target:addSpell(345)
end
