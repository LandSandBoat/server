-----------------------------------------
-- ID: 4632
-- Scroll of Dia II
-- Teaches the white magic Dia II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(24)
end

function onItemUse(target)
    target:addSpell(24)
end
