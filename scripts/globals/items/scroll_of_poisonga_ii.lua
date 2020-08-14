-----------------------------------------
-- ID: 4834
-- Scroll of Poisonga II
-- Teaches the black magic Poisonga II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(226)
end

function onItemUse(target)
    target:addSpell(226)
end
