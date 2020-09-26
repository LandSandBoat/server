-----------------------------------------
-- ID: 18122
-- Item: Broach Lance
-- Item Effect: TP +10
-- Duration: Instant
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addTP(100)
end
