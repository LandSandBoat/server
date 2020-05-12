-----------------------------------------
-- ID: 4862
-- Scroll of Blind
-- Teaches the black magic Blind
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(254)
end

function onItemUse(target)
    target:addSpell(254)
end
