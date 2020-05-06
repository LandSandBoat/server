-----------------------------------------
-- ID: 4723
-- Scroll of Enblizzard II
-- Teaches the white magic Enblizzard II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(313)
end

function onItemUse(target)
    target:addSpell(313)
end
