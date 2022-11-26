-----------------------------------
--  ID: 16118
--  Moogle Cap
--  Transports the user to their Home Nation
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local nation = target:getNation(target)

    if nation == 0 then -- San d'Oria
        target:setPos(126, 0, -1, 122, 231)
    elseif nation == 1 then -- Bastok
        target:setPos(106, 0, -71, 130, 234)
    elseif nation == 2 then -- Windurst
        target:setPos(197, -12, 224, 65, 240)
    end
end

return itemObject
