-----------------------------------------
-- ID: 4606
-- Scroll of Dia
-- Teaches the white magic Dia
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(23)
end

function onItemUse(target)
    target:addSpell(23)
end
