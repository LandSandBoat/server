-----------------------------------------
-- ID: 4628
-- Scroll of Cursna
-- Teaches the white magic Cursna
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(20)
end

function onItemUse(target)
    target:addSpell(20)
end
