-----------------------------------
-- ID: 5911
-- Item: Olde Rarab Tail
-- Effect: 90 Seconds of "Terror" effect.
-----------------------------------
local itemObject = {}

itemObject.onItemCheck = function(target)
    return 0
end

itemObject.onItemUse = function(target)
    local ID = zones[target:getZoneID()]

    if
        not target:hasStatusEffect(xi.effect.TERROR) and
        (target:getID() == ID.mob.ATORI_TUTORI_QM[1] or
        target:getID() == ID.mob.ATORI_TUTORI_QM[2] or
        target:getID() == ID.mob.ATORI_TUTORI_QM[3])
    then
        target:addStatusEffect(xi.effect.TERROR, 1, 3, 90)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
