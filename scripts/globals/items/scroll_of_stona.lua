-----------------------------------------
-- ID: 4626
-- Scroll of Stona
-- Teaches the white magic Stona
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(18)
end

function onItemUse(target)
    target:addSpell(18)
end
