-----------------------------------------
-- ID: 5100
-- Scroll of Boost-CHR
-- Teaches the white magic Boost-CHR
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(485)
end

function onItemUse(target)
    target:addSpell(485)
end
