-----------------------------------------
-- ID: 5065
-- Scroll of Earth Threnody
-- Teaches the song Earth Threnody
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(457)
end

function onItemUse(target)
    target:addSpell(457)
end
