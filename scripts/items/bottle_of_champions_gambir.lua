-----------------------------------
-- ID: 5844
-- Item: bottle_of_champions_gambir
-- Item Effect: Haste (Magic) 18% - CRITHITRATE 5%
-----------------------------------

local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local effect    = xi.effect.POTENCY
    local power     = 1800  --haste
    local subpower  = 5     --crit
    local duration  = 60

    xi.itemUtils.addItemEffect(target, effect, power, duration, subpower)
end

return itemObject
