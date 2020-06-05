-----------------------------------------
-- ID: 6059
-- Item: Animus Augeo Schema
-- Teaches the white magic Animus Augeo
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(308)
end

function onItemUse(target)
    target:addSpell(308)
end
