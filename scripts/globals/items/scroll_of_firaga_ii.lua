-----------------------------------------
-- ID: 4783
-- Scroll of Firaga II
-- Teaches the black magic Firaga II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(175)
end

function onItemUse(target)
    target:addSpell(175)
end
