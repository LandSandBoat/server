-----------------------------------------
-- ID: 4765
-- Scroll of Aero IV
-- Teaches the black magic Aero IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(157)
end

function onItemUse(target)
    target:addSpell(157)
end
