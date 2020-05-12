-----------------------------------------
-- ID: 5008
-- Scroll of Blade Madrigal
-- Teaches the song Blade Madrigal
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(400)
end

function onItemUse(target)
    target:addSpell(400)
end
