-----------------------------------------
-- ID: 16285
-- Pendant compass
--  Use to determine your precise location in Vana'diel.
--  Provides exact X, Y and Z location, where Y is the altitude.
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    target:showPosition()
end
