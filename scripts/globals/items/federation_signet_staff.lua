-----------------------------------------
-- ID: 17585
-- Item: Federation Signet Staff
-- Effect: Signet
-----------------------------------------
require("scripts/globals/status")
require("scripts/globals/conquest")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target, param, caster)
    if (target:getNation() ~= tpz.nation.WINDURST) then
        return tpz.msg.basic.ITEM_CANNOT_USE_ON
    end

    -- If target's current region is not a conquest region or not a nation city involved with conquest
    if (target:getCurrentRegion() > tpz.region.JEUNO) then
        return tpz.msg.basic.ITEM_UNABLE_TO_USE
    end

    -- Can only use on targets within party or self
    if (target:getID() ~= caster:getID()) then
        if (caster:getPartyLeader() == nil or target:getPartyLeader():getID() ~= caster:getPartyLeader():getID()) then
            return tpz.msg.basic.ITEM_CANNOT_USE_ON
        end
    end

    return 0
end

function onItemUse(target)
    target:delStatusEffectsByFlag(tpz.effectFlag.INFLUENCE, true)
    target:addStatusEffect(tpz.effect.SIGNET, 0, 0, 18000)
end
