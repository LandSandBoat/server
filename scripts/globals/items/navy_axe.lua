-----------------------------------------
-- ID: 17957
-- Item: Navy Axe
-- Item Effect: TP +100
-- Duration: Instant
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addTP(1000)
end
