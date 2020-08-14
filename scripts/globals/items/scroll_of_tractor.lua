-----------------------------------------
-- ID: 4872
-- Scroll of Tractor
-- Teaches the black magic Tractor
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(264)
end

function onItemUse(target)
    target:addSpell(264)
end
