-----------------------------------
-- ID: 5165
-- Item: Bottle of Movalpolos Water
-- Item Effect: Refresh 2 MP 3/Tic under 85% MP.
-- Duration: 30 Mins
-----------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local mMP = target:getMaxMP()
    local cMP = target:getMP()
    if VanadielDayOfTheWeek() == xi.day.LIGHTSDAY then
        if cMP < (mMP * .85) then
            if not target:hasStatusEffect(xi.effect.REFRESH) then
                target:addStatusEffect(xi.effect.REFRESH, 2, 3, 1800)
            else
                target:messageBasic(xi.msg.basic.NO_EFFECT)
            end
        else
            target:messageBasic(xi.msg.basic.NO_EFFECT)
        end
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
