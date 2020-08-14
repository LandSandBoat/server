-----------------------------------------
-- ID: 5067
-- Scroll of Water Threnody
-- Teaches the song Water Threnody
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(459)
end

function onItemUse(target)
    target:addSpell(459)
end
