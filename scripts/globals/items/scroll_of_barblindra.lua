-----------------------------------------
-- ID: 4697
-- Scroll of Barblindra
-- Teaches the white magic Barblindra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(89)
end

function onItemUse(target)
    target:addSpell(89)
end
