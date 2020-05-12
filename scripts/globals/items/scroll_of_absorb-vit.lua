-----------------------------------------
-- ID: 4876
-- Scroll of Absorb-VIT
-- Teaches the black magic Absorb-VIT
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(268)
end

function onItemUse(target)
    target:addSpell(268)
end
