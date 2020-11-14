-----------------------------------------
-- ID: 5165
-- Item: Bottle of Movalpolos Water
-- Item Effect: Refresh 2 MP 3/Tic under 85% MP.
-- Duration: 30 Mins
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/msg")

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local mMP = target:getMaxMP()
    local cMP = target:getMP()
    if (VanadielDayOfTheWeek() == tpz.day.LIGHTSDAY) then
        if (cMP < (mMP * .85)) then
            if (not target:hasStatusEffect(tpz.effect.REFRESH)) then
                target:addStatusEffect(tpz.effect.REFRESH, 2, 3, 1800)
            else
                target:messageBasic(tpz.msg.basic.NO_EFFECT)
            end
        else
            target:messageBasic(tpz.msg.basic.NO_EFFECT)
        end
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
