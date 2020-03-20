-----------------------------------------
-- ID: 5056
-- Scroll of Wind Carol II
-- Teaches the song Wind Carol II
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(448)
end

function onItemUse(target)
    target:addSpell(448)
end
