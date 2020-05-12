-----------------------------------------
-- ID: 4727
-- Scroll of Enwater II
-- Teaches the white magic Enwater II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(317)
end

function onItemUse(target)
    target:addSpell(317)
end
