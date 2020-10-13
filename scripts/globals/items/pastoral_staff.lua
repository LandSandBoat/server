-----------------------------------------
-- ID: 18591
-- Item: Pastoral Staff
-- Item Effect: TP +100
-- Duration: Instant
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addTP(1000)
end
