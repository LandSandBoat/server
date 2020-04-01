-----------------------------------------
-- ID: 4716
-- Scroll of Regen
-- Teaches the white magic Regen
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(108)
end

function onItemUse(target)
    target:addSpell(108)
end
