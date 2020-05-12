-----------------------------------------
-- ID: 4818
-- Scroll of Quake
-- Teaches the black magic Quake
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(210)
end

function onItemUse(target)
    target:addSpell(210)
end
