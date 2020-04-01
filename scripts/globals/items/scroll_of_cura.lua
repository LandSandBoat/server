-----------------------------------------
-- ID: 4701
-- Scroll of Cura
-- Teaches the white magic Cura
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(93)
end

function onItemUse(target)
    target:addSpell(93)
end
