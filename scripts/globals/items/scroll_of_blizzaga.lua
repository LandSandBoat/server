-----------------------------------------
-- ID: 4787
-- Scroll of Blizzaga
-- Teaches the black magic Blizzaga
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(179)
end

function onItemUse(target)
    target:addSpell(179)
end
