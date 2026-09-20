-----------------------------------
-- ID: 16943
-- Item: Ascalon
-- Additional effect: light damage
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    -- TODO: does Dragon Affinity cover this?
    if not target:isMob() and target:getEcosystem() ~= xi.ecosystem.DRAGON then
        return 0, 0, 0
    end

    -- This is really wrong. It's based off Arondight (a similar sword) which appears to have two knees?
    -- Needs testing.
    local dStat = actor:getStat(xi.mod.MND) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = 100,
        basePower      = 13 + utils.clamp(dStat * 0.9, 0, 84), -- Averaged over the whole range
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.LIGHT,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

return itemObject
