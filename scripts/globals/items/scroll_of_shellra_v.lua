-----------------------------------------
-- ID: 4742
-- Scroll of Shellra V
-- Teaches the white magic Shellra V
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(134)
end

function onItemUse(target)
    target:addSpell(134)
end
