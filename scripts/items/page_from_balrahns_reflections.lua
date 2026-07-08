-----------------------------------
-- ID: 5415
-- Item:  Hero's Reflections
-- Grants 200 - 500 EXP
-- Does not grant Limit Points.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, caster)
    local check = 56
    if target:getMainLvl() >= 60 then
        check = 0
    end

    return check
end

itemObject.onItemUse = function(target)
    target:addExp(xi.settings.main.EXP_RATE * math.randomInt(200, 500))
end

return itemObject
