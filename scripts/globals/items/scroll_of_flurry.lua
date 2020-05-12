-----------------------------------------
-- ID: 5104
-- Scroll of Flurry
-- Teaches the white magic Flurry
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(845)
end

function onItemUse(target)
    target:addSpell(845)
end
