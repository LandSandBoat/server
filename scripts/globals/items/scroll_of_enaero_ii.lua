-----------------------------------------
-- ID: 4724
-- Scroll of Enaero II
-- Teaches the white magic Enaero II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(314)
end

function onItemUse(target)
    target:addSpell(314)
end
