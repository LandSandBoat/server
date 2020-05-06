-----------------------------------------
-- ID: 4718
-- Scroll of Regen II
-- Teaches the white magic Regen II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(110)
end

function onItemUse(target)
    target:addSpell(110)
end
