-----------------------------------------
-- ID: 5083
-- Scroll of Cura III
-- Teaches the white magic Cura III
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(475)
end

function onItemUse(target)
    target:addSpell(475)
end
