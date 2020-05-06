-----------------------------------------
-- ID: 6055
-- Item: Aurorastorm Schema
-- Teaches the white magic Aurorastorm
-----------------------------------------

function onItemCheck(target)
    return target:canLearnSpell(119)
end

function onItemUse(target)
    target:addSpell(119)
end
