-----------------------------------------
-- ID: 4895
-- Scroll of Waterja
-- Teaches the Black magic Waterja
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(501)
end

function onItemUse(target)
    target:addSpell(501)
end
