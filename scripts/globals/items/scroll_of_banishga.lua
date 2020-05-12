-----------------------------------------
-- ID: 4646
-- Scroll of Banishga
-- Teaches the white magic Banishga
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(38)
end

function onItemUse(target)
    target:addSpell(38)
end
