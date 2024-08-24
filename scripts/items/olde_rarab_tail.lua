-----------------------------------
-- ID: 5911
-- Item: Olde Rarab Tail
-- Effect: 90 Seconds of "Terror" effect.
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemCheck = function(target, item, param, caster)
    return 0
end

itemObject.onItemUse = function(target)
    local ID = zones[target:getZoneID()]

    if
        not target:hasStatusEffect(xi.effect.TERROR) and
        (target:getID() == ID.mob.ATORI_TUTORI or
        target:getID() == ID.mob.ATORI_TUTORI + 1 or
        target:getID() == ID.mob.ATORI_TUTORI + 2)
    then
        target:addStatusEffect(xi.effect.TERROR, 1, 3, 90)
    else
        target:messageBasic(xi.msg.basic.NO_EFFECT)
    end
end

return itemObject
