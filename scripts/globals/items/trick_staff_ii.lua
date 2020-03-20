-----------------------------------------
--  ID: 17587
--  Trick Staff II
--  Transports the user to their Home Point
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:warp()
end
