-----------------------------------
-- Global file for globably/commonly used entity behavior/patterns.
-----------------------------------
require('scripts/globals/combat/entity_behavior_data')
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.behavior = xi.combat.behavior or {}
-----------------------------------

xi.combat.behavior.isEntityBusy = function(actor)
    -- Check poses (actions).
    local currAction = actor:getCurrentAction()
    if
        currAction ~= xi.action.category.NONE and
        currAction ~= xi.action.category.BASIC_ATTACK and-- TODO: What does "ATTACK" entail? Just swinging or engaged in general?
        currAction ~= xi.action.category.ROAMING
    then
        return true
    end

    -- Check action queue.
    if
        not actor:isPC() and
        not actor:actionQueueEmpty()
    then
        return true
    end

    -- Check status effects.
    if
        actor:hasStatusEffect(xi.effect.SLEEP_I) or
        actor:hasStatusEffect(xi.effect.SLEEP_II) or -- Unused, but let's check it anyway, for the future.
        actor:hasStatusEffect(xi.effect.LULLABY) or  -- Unused, but let's check it anyway, for the future.
        actor:hasStatusEffect(xi.effect.STUN) or
        actor:hasStatusEffect(xi.effect.TERROR) or
        actor:hasStatusEffect(xi.effect.PETRIFICATION)
    then
        return true
    end

    -- Check "isBusy" local variable. For special actions (Bahamut's Megaflare or Ultima's... Ultima, for example).
    if actor:getLocalVar('isBusy') > 0 then
        return true
    end

    return false
end

-- For "decoration" type mobs and faked actions.
xi.combat.behavior.disableAllActions = function(actor)
    actor:setAutoAttackEnabled(false)
    actor:setMagicCastingEnabled(false)
    actor:setMobAbilityEnabled(false)
end

xi.combat.behavior.enableAllActions = function(actor)
    actor:setAutoAttackEnabled(true)
    actor:setMagicCastingEnabled(true)
    actor:setMobAbilityEnabled(true)
end

-----------------------------------
-- Action choose functions.
-----------------------------------
local function validateParameters(fedParameters)
    local params = {}

    -- Common parmeters.
    params.spellId             = utils.defaultIfNil(fedParameters.spellId, 0)
    params.category            = utils.defaultIfNil(xi.combat.behavior.spellData[params.spellId][1], xi.action.type.NONE)
    params.isSelfTarget        = utils.defaultIfNil(xi.combat.behavior.spellData[params.spellId][2], false)
    params.distance            = utils.defaultIfNil(fedParameters.distance, 8)
    params.weight              = utils.defaultIfNil(fedParameters.weight, 100)

    -- Effect parameters.
    params.healsEffectId       = utils.defaultIfNil(fedParameters.healsEffectId, xi.combat.behavior.spellData[params.spellId][3])
    params.appliesEffectId     = utils.defaultIfNil(fedParameters.appliesEffectId, xi.combat.behavior.spellData[params.spellId][4])
    params.effectTier          = utils.defaultIfNil(fedParameters.effectTier, xi.combat.behavior.spellData[params.spellId][5])

    -- Evaluation conditions.
    params.evaluateAlive       = utils.defaultIfNil(fedParameters.evaluateAlive, true)
    params.evaluateUndead      = utils.defaultIfNil(fedParameters.evaluateUndead, false)
    params.evaluateEntityPets  = utils.defaultIfNil(fedParameters.evaluateEntityPets, false)
    params.evaluateDispel      = utils.defaultIfNil(fedParameters.evaluateDispel, false)
    params.evaluateErase       = utils.defaultIfNil(fedParameters.evaluateErase, false)
    params.evaluateAllyTargets = utils.defaultIfNil(fedParameters.evaluateAllyTargets, xi.combat.behavior.spellData[params.spellId][6])
    params.evaluateFoeTargets  = utils.defaultIfNil(fedParameters.evaluateFoeTargets, xi.combat.behavior.spellData[params.spellId][7])
    params.evaluateHPP         = utils.defaultIfNil(fedParameters.hpp, 100) -- Target HPP must be this % or lower.
    params.evaluateMP          = utils.defaultIfNil(fedParameters.mp, 0)    -- Target MPP must be this % or higher.
    params.evaluateTP          = utils.defaultIfNil(fedParameters.tp, 0)    -- Target TP must be this value or higher.

    return params
end

local function judgeEntity(actor, entity, params, validTargets, targetAmount)
    -- Early return: Target entity doesn't exist.
    if not entity then
        return validTargets, targetAmount
    end

    -- Early return: Target is not supposed to be targetable.
    if entity:getUntargetable() then
        return validTargets, targetAmount
    end

    -- Early return: Target needs to be alivwe and isn't.
    if params.evaluateAlive and not entity:isAlive() then
        return validTargets, targetAmount
    end

    -- Early return: Target is too far from caster.
    if entity:checkDistance(actor) > params.distance then
        return validTargets, targetAmount
    end

    -- Early return: Target doesn't have enough HP to be casted.
    if entity:getHPP() > params.evaluateHPP then
        return validTargets, targetAmount
    end

    -- Early return: Target doesn't have enough MP to be casted.
    if entity:getMP() < params.evaluateMP then
        return validTargets, targetAmount
    end

    -- Early return: Target doesn't have enough TP to be casted.
    if entity:getTP() < params.evaluateTP then
        return validTargets, targetAmount
    end

    -- Early return: Erase-type spell.
    if params.evaluateErase then
        if not entity:hasStatusEffectByFlag(xi.effectFlag.ERASABLE) then
            return validTargets, targetAmount
        end
    end

    -- Early return: Dispel-type spell.
    if params.evaluateDispel then
        if not entity:hasStatusEffectByFlag(xi.effectFlag.DISPELABLE) then
            return validTargets, targetAmount
        end
    end

    -- Early return: Spell heals status and target doesn't have said status.
    if params.healsEffectId then
        if not entity:hasStatusEffect(params.healsEffectId) then
            return validTargets, targetAmount
        end
    end

    -- Spell adds status to target.
    if params.appliesEffectId then
        if entity:hasStatusEffect(params.appliesEffectId) then
            return validTargets, targetAmount
        end

       -- Early return: Effect wouldn't be applied.
        if xi.data.statusEffect.isEffectNullified(entity, params.appliesEffectId, params.effectTier) then
            return validTargets, targetAmount
        end

        -- Special condition: Silence
        if params.appliesEffectId == xi.effect.SILENCE then
            if not xi.data.job.isInnateCaster(entity) then
                return validTargets, targetAmount
            end

        -- Special condition: Elemental DoT incompatibilities. This will ensure we only cast stackable effects.
        elseif
            params.appliesEffectId == xi.effect.BURN or
            params.appliesEffectId == xi.effect.CHOKE or
            params.appliesEffectId == xi.effect.DROWN or
            params.appliesEffectId == xi.effect.FROST or
            params.appliesEffectId == xi.effect.RASP or
            params.appliesEffectId == xi.effect.SHOCK
        then
            if entity:hasStatusEffect(xi.data.statusEffect.getEffectToRemove(params.appliesEffectId)) then
                return validTargets, targetAmount
            end

            if entity:hasStatusEffect(xi.data.statusEffect.getNullificatingEffect(params.appliesEffectId)) then
                return validTargets, targetAmount
            end
        end
    end

    table.insert(validTargets, { entity })

    return validTargets, targetAmount + 1
end

local function handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, isForcedOnSelf)
    local validTargets = {} -- Table with all possible targets of this action.
    local targetAmount = 0  -- Number of possible targets.

    -- Check and add main target into the list.
    validTargets, targetAmount = judgeEntity(actor, mainTarget, params, validTargets, targetAmount)

    -- Check optional targets in ally list.
    if allyEntityTable and params.evaluateAllyTargets then
        for _, targetEntity in pairs(allyEntityTable) do
            validTargets, targetAmount = judgeEntity(actor, targetEntity, params, validTargets, targetAmount)

            if params.includePet then
                local petEntity = targetEntity:getPet()
                if petEntity then
                    validTargets, targetAmount = judgeEntity(actor, petEntity, params, validTargets, targetAmount)
                end
            end
        end
    end

    -- Check optional targets in foe list.
    if foeEntityTable and params.evaluateFoeTargets then
        for _, targetEntity in pairs(foeEntityTable) do
            validTargets, targetAmount = judgeEntity(actor, targetEntity, params, validTargets, targetAmount)

            if params.includePet then
                local petEntity = targetEntity:getPet()
                if petEntity then
                    validTargets, targetAmount = judgeEntity(actor, petEntity, params, validTargets, targetAmount)
                end
            end
        end
    end

    -- Add all valid entries to the action list.
    local actionList = {}
    if targetAmount > 0 then
        for _, validEntity in pairs(validTargets) do
            local targetEntity = isForcedOnSelf and actor or validEntity
            table.insert(actionList, { params.spellId, targetEntity, params.weight / targetAmount })
        end
    end

    return actionList
end

xi.combat.behavior.chooseSpell = function(actor, target, actionTable, allyEntityTable, foeEntityTable)
    local actionList = {}

    -- Build new table with actions that meet the conditions.
    for entry = 1, #actionTable do
        local params     = validateParameters(actionTable[entry])
        local mainTarget = params.isPositive and actor or target

        switch (params.category): caseof
        {
            [xi.action.type.NONE] = function()
            end,

            [xi.action.type.DAMAGE_TARGET] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, false)
            end,

            [xi.action.type.DAMAGE_FORCE_SELF] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, true)
            end,

            [xi.action.type.HEALING_TARGET] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, false)
            end,

            -- For Self-targeted AoE cures.
            [xi.action.type.HEALING_FORCE_SELF] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, true)
            end,

            [xi.action.type.HEALING_EFFECT] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, false)
            end,

            [xi.action.type.HEALING_EFFECT_FORCE_SELF] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, true)
            end,

            [xi.action.type.ENHANCING_TARGET] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, false)
            end,

            -- For Self-targeted AoE enhancements.
            [xi.action.type.ENHANCING_FORCE_SELF] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, true)
            end,

            [xi.action.type.ENFEEBLING_TARGET] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, false)
            end,

            -- For self-targeted AoE enfeeblements. Use with care.
            [xi.action.type.ENFEEBLING_FORCE_SELF] = function()
                actionList = handleActionList(actor, mainTarget, params, allyEntityTable, foeEntityTable, true)
            end,

            [xi.action.type.DISPEL] = function()
            end,

            [xi.action.type.SUMMONING] = function()
            end,
        }
    end

    -- Something went wrong.
    if #actionList == 0 then
        return nil, nil
    end

    -- Calculate total weight of the new list.
    local totalWeight = 0
    for i = 1, #actionList do
        totalWeight = totalWeight + actionList[i][3]
    end

    -- Choose action and target.
    local randomRoll  = math.random(1, totalWeight)
    local chosenEntry = 0
    local weight      = 0
    for i = 1, #actionList do
        weight = weight + actionList[i][3]
        if randomRoll <= weight then
            chosenEntry = i
            break
        end
    end

    return actionList[chosenEntry][1], actionList[chosenEntry][2]
end
