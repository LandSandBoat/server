-----------------------------------------
-- ID: 5068
-- Scroll of Light Threnody
-- Teaches the song Light Threnody
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(460)
end

function onItemUse(target)
    target:addSpell(460)
end
