-----------------------------------------
-- ID: 6061
-- Item: Adloquium Schema
-- Teaches the white magic Adloquium
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(495)
end

function onItemUse(target)
    target:addSpell(495)
end
