-----------------------------------
-- ID: 17828
-- Item: Koen
-- Enchantment: Enfire
-- Duration:
-----------------------------------
---@type TItem
local itemObject = {}

itemObject.onItemAdditionalEffect = function(actor, target, baseAttackDamage, item)
    local pTable =
    {
        chance          = 7, -- TODO: Homura scales with INT. does this?
        basePower       = math.randomInt(6, 8),
        attackType      = xi.attackType.MAGICAL,
        magicalElement  = xi.element.FIRE,
        canMAB          = false,
        canResist       = true,
        lowestResist    = 0.5,
    }

    return xi.combat.action.executeAddEffectDamage(actor, target, pTable)
end

itemObject.onItemCheck = function(target, user)
    if target:getStatusEffectBySource(xi.effect.ENFIRE, xi.effectSourceType.EQUIPPED_ITEM, xi.item.KOEN) ~= nil then
        target:delStatusEffect(xi.effect.ENFIRE, nil, xi.effectSourceType.EQUIPPED_ITEM, xi.item.KOEN)
    end

    return 0
end

itemObject.onItemUse = function(target, user)
    if target:hasEquipped(xi.item.KOEN) then
        target:addStatusEffect(xi.effect.ENFIRE, { duration = 180, origin = user, sourceType = xi.effectSourceType.EQUIPPED_ITEM, sourceTypeParam = xi.item.KOEN })
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

    effect:addMod(xi.mod.ENSPELL, xi.element.FIRE)
    effect:addMod(xi.mod.ENSPELL_DMG, potency)
    effect:addMod(xi.mod.ENSPELL_CHANCE, 100)
end

itemObject.onEffectLose = function(target, effect)
end

return itemObject
