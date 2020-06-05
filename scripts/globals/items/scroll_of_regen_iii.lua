-----------------------------------------
-- ID: 4719
-- Scroll of Regen III
-- Teaches the white magic Regen III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(111)
end

function onItemUse(target)
    target:addSpell(111)
end
