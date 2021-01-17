-----------------------------------------
--  ID: 16119
--  Nomad Cap
--  Transports the user to their Home Nation
-----------------------------------------
local item_object = {}

item_object.onItemCheck = function(target)
    return 0
end

item_object.onItemUse = function(target)
    local nation = target:getNation(target)
    if (nation == 0) then -- San d'Oria
        target:setPos(126, 0, -1, 122, 231)
        return
    end
    if (nation == 1) then -- Bastok
        target:setPos(106, 0, -71, 130, 234)
        return
    end
    if (nation == 2) then -- Windurst
        target:setPos(197, -12, 224, 65, 240)
        return
    end
    print( "Unable to fetch target's nation." )
end

return item_object
