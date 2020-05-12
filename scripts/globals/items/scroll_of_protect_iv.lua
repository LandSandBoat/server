-----------------------------------------
-- ID: 4654
-- Scroll of Protect IV
-- Teaches the white magic Protect IV
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(46)
end

function onItemUse(target)
    target:addSpell(46)
end
