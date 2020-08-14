-----------------------------------------
-- ID: 4781
-- Scroll of Water V
-- Teaches the black magic Water V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(173)
end

function onItemUse(target)
    target:addSpell(173)
end
