-----------------------------------------
-- ID: 6060
-- Item: Animus Minuo Schema
-- Teaches the white magic Animus Minuo
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(309)
end

function onItemUse(target)
    target:addSpell(309)
end
