-----------------------------------------
-- ID: 4738
-- Scroll of Shellra
-- Teaches the white magic Shellra
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(130)
end

function onItemUse(target)
    target:addSpell(130)
end
