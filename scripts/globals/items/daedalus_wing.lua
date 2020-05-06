-----------------------------------------
-- ID: 4202
-- Daedalus Wing
-- Increases TP of the user by 100
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:addTP(1000)
end
