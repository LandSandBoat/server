-----------------------------------------
-- ID: 5064
-- Scroll of Wind Threnody
-- Teaches the song Wind Threnody
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(456)
end

function onItemUse(target)
    target:addSpell(456)
end
