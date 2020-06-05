-----------------------------------------
-- ID: 4893
-- Scroll of Stoneja
-- Teaches the black magic Stoneja
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(499)
end

function onItemUse(target)
    target:addSpell(499)
end
