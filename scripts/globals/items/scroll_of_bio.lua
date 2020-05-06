-----------------------------------------
-- ID: 4838
-- Scroll of Bio
-- Teaches the black magic Bio
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(230)
end

function onItemUse(target)
    target:addSpell(230)
end
