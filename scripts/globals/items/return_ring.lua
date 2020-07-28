-----------------------------------------
-- ID: 15542
-- Teleport Return Ring
-- Enchantment: "Outpost Warp"
-----------------------------------------
require("scripts/globals/teleports")
require("scripts/globals/conquest")
require("scripts/globals/status")
require("scripts/globals/zone")
require("scripts/globals/msg")
-----------------------------------------

function onItemCheck(target)
    local result = 0
    local region = target:getCurrentRegion()

    if not tpz.conq.canTeleportToOutpost(target, region) or GetRegionOwner(region) ~= target:getNation() then
        result = tpz.msg.basic.CANT_BE_USED_IN_AREA
    end

    return result
end

function onItemUse(target)
    local region = target:getCurrentRegion()
    target:addStatusEffectEx(tpz.effect.TELEPORT, 0, tpz.teleport.id.OUTPOST, 0, 1, 0, region)
end
