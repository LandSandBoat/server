-----------------------------------
-- ID: 17415
-- Item: Shellbuster
-- Additional effect: lightning damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local family = target:isMob() and target:getFamily() or xi.mobFamily.UNCLASSIFIED

    if family ~= xi.mobFamily.QUADAV then
        return 0, 0, 0
    end

    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 10 + utils.clamp(math.floor(dStat * 0.0926), 0, 5), -- 10 + 0-5% over 54 dINT
        basePower      = math.randomInt(9, 12),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.THUNDER,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
