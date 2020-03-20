-----------------------------------------
-- ID: 4764
-- Scroll of Aero III
-- Teaches the black magic Aero III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(156)
end

function onItemUse(target)
    target:addSpell(156)
end
