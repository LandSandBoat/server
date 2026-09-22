-----------------------------------
-- ID: 16853
-- Item: Lizard Piercer
-- Additional effect: ice damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    if not target:isMob() or target:getFamily() ~= xi.mobFamily.LIZARD then
        return 0, 0, 0
    end

    local dStat  = actor:getStat(xi.mod.INT) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 5 + utils.clamp(dStat * 5 / 54, 0, 5), -- 5% over 54
        basePower      = math.randomInt(6, 8),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.ICE,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
