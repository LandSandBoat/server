-----------------------------------
-- ID: 17135
-- Item: Ulfhedinn Axe
-- Additional effect: ice damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    if not target:isMob() or target:getFamily() ~= xi.mobFamily.HOUND then
        return 0, 0, 0
    end

    local pTable =
    {
        chance         = 15,
        basePower      = math.randomInt(7, 10),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.ICE,
        canMAB         = false,
        canResist      = true,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
