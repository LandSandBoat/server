-----------------------------------------
-- ID: 4758
-- Scroll of Blizzard II
-- Teaches the black magic Blizzard II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(150)
end

function onItemUse(target)
    target:addSpell(150)
end
