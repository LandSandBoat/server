-----------------------------------------
-- ID: 4662
-- Scroll of Stoneskin
-- Teaches the white magic Stoneskin
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(54)
end

function onItemUse(target)
    target:addSpell(54)
end
