-----------------------------------------
-- ID: 6048
-- Noctohelix Schema
-- Teaches the black magic Noctohelix
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(284)
end

function onItemUse(target)
    target:addSpell(284)
end
