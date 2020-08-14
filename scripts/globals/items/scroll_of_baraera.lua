-----------------------------------------
-- ID: 4676
-- Scroll of Baraera
-- Teaches the white magic Baraera
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(68)
end

function onItemUse(target)
    target:addSpell(68)
end
