-----------------------------------------
-- ID: 5911
-- Item: Olde Rarab Tail
-- Effect: 90 Seconds of "Terror" effect.
-----------------------------------------
require("scripts/globals/status")
-----------------------------------------

function onItemCheck(target)
    return 0
end

function onItemUse(target)
    local typeEffect = tpz.effect.TERROR
    local duration = 90
    local ID = zones[target:getZoneID()]

    if not target:hasStatusEffect(typeEffect) and (target:getID() == ID.mob.ATORI_TUTORI_QM[1] or
    target:getID() == ID.mob.ATORI_TUTORI_QM[2] or target:getID() == ID.mob.ATORI_TUTORI_QM[3]) then
        target:addStatusEffect(typeEffect,1,3,duration)
    else
        target:messageBasic(tpz.msg.basic.NO_EFFECT)
    end
end
