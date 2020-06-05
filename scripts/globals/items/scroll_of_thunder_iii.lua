-----------------------------------------
-- ID: 4774
-- Scroll of Thunder III
-- Teaches the black magic Thunder III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(166)
end

function onItemUse(target)
    target:addSpell(166)
end
