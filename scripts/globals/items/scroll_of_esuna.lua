-----------------------------------------
-- ID: 4703
-- Scroll of Esuna
-- Teaches the white magic Esuna
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(95)
end

function onItemUse(target)
    target:addSpell(95)
end
