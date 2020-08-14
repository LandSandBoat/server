-----------------------------------------
-- ID: 4691
-- Scroll of Baramnesra
-- Teaches the white magic Baramnesra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(85)
end

function onItemUse(target)
    target:addSpell(85)
end
