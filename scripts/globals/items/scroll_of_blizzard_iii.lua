-----------------------------------------
-- ID: 4759
-- Scroll of Blizzard III
-- Teaches the black magic Blizzard III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(151)
end

function onItemUse(target)
    target:addSpell(151)
end
