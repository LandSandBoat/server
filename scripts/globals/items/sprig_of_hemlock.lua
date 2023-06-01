-----------------------------------
-- ID: 5985
-- Item: Sprig of Hemlock
-- Food Effect: 5 Min, All Races
-- Paralysis
-----------------------------------
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    if not target:hasStatusEffect(xi.effect.PARALYSIS) then
        target:addStatusEffect(xi.effect.PARALYSIS, 20, 0, 600)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
