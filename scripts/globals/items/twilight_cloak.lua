-----------------------------------
-- ID: 11363
-- Equip: Twilight Cloak
-- Able to cast "Impact"
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    local body = target:getEquipID(xi.slot.BODY)

    if body == 11363 then
        target:addSpell(503)
    else
        target:delSpell(503)
    end
end

return itemObject
