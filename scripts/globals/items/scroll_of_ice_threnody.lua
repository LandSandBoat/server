-----------------------------------------
-- ID: 5063
-- Scroll of Ice Threnody
-- Teaches the song Ice Threnody
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(455)
end

function onItemUse(target)
    target:addSpell(455)
end
