-----------------------------------
-- ID: 18392
-- Item: Sacred Maul
-- Additional effect: light damage
-- Enchantment: Enlight
-- Duration: 3 minutes
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local dStat = actor:getStat(xi.mod.MND) - target:getStat(xi.mod.INT)
    local pTable =
    {
        chance         = utils.clamp(dStat * 4 / 9, 0, 24), -- Seems to be a linear scale over 54 dSTAT, 4 / 9 = 0.4444...
        basePower      = math.randomInt(7, 9),
        attackType     = xi.attackType.MAGICAL,
        magicalElement = xi.element.LIGHT,
        canMAB         = false,
        canResist      = true,
        lowestResist   = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

itemObject.onItemCheck = function(target, user)
    if target:getStatusEffectBySource(xi.effect.ENLIGHT, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SACRED_MAUL) ~= nil then
        target:delStatusEffect(xi.effect.ENLIGHT, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.SACRED_MAUL)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.SACRED_MAUL) then
        target:addStatusEffect(xi.effect.ENLIGHT, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.SACRED_MAUL })
    end
end

itemObject.onEffectGain = function(target, effect)
    local magicskill = target:getSkillLevel(xi.skill.ENHANCING_MAGIC)
    local potency = 0

    if magicskill <= 200 then
        potency = 3 + math.floor(6 * magicskill / 100)
    elseif magicskill > 200 then
        potency = 5 + math.floor(5 * magicskill / 100)
    end

    potency = utils.clamp(potency, 3, 25)
    effect:addMod(xi.mod.ENSPELL, xi.element.LIGHT)
    effect:addMod(xi.mod.ENSPELL_DMG, potency)
    effect:addMod(xi.mod.ENSPELL_CHANCE, 100)
end

-- Needed for onEffectGain to work
itemObject.onEffectLose = function(target, effect)
end

return itemObject
