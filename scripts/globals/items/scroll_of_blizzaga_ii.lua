-----------------------------------------
-- ID: 4788
-- Scroll of Blizzaga II
-- Teaches the black magic Blizzaga II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(180)
end

function onItemUse(target)
    target:addSpell(180)
end
