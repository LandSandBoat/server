-----------------------------------------
-- ID: 4808
-- Scroll of Waterga II
-- Teaches the black magic Waterga II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(200)
end

function onItemUse(target)
    target:addSpell(200)
end
