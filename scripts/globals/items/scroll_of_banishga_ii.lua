-----------------------------------------
-- ID: 4647
-- Scroll of Banishga II
-- Teaches the white magic Banishga II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(39)
end

function onItemUse(target)
    target:addSpell(39)
end
