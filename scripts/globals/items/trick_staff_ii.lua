-----------------------------------
--  ID: 17587
--  Trick Staff II
--  Transports the user to their Home Point
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    target:warp()
end

return itemObject
