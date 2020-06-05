-----------------------------------------
-- ID: 4682
-- Scroll of Barparalyze
-- Teaches the white magic Barparalyze
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(74)
end

function onItemUse(target)
    target:addSpell(74)
end
