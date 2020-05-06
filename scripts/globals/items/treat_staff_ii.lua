-----------------------------------------
--  ID: 17588
--  Treat staff II
--  Transports the user to their Home Point
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:warp()
end
