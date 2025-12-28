-----------------------------------
-- Global file for globably/commonly used entity behavior/patterns.
-----------------------------------
xi = xi or {}
xi.combat = xi.combat or {}
xi.combat.behavior = xi.combat.behavior or {}

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

xi.combat.behavior.chooseAction = function(actor, mainTarget, optionalTargets, actionTable)
    local actionList = {}

    -- Build new table with actions that meet the conditions.
    for entry = 1, #actionTable do
        local actionId          = actionTable[entry][1] -- The ID of the action.
        local actionTarget      = actionTable[entry][2] -- The main target of the action.
        local actionAllowAllies = actionTable[entry][3] -- Boolean. Determine if we check "optionalTargets" tables for the condition. NOTE: Needs condition.
        local actionType        = actionTable[entry][4] -- Determines the condition type.
        local actionCondition   = actionTable[entry][5] -- The condition. (HP/MP under threshold, effect present.)
        local actionWeight      = actionTable[entry][6] -- How likely it will be for the action to be chosen.

        switch (actionType): caseof
        {
            [xi.action.type.NONE] = function()
                table.insert(actionList, { actionId, actionTarget, actionWeight })
            end,

            [xi.action.type.DAMAGE_TARGET] = function()
                table.insert(actionList, { actionId, actionTarget, actionWeight })
            end,

            [xi.action.type.DAMAGE_FORCE_SELF] = function()
                table.insert(actionList, { actionId, actor, actionWeight })
            end,

            [xi.action.type.HEALING_TARGET] = function()
                -- Check self.
                if actor:getHPP() <= actionCondition then
                    table.insert(actionList, { actionId, actor, actionWeight })
                end

                -- Check allies.
                if actionAllowAllies and optionalTargets then
                    local actorId = actor:getID()
                    for i = 1, #optionalTargets do
                        local value = optionalTargets[i]
                        if value ~= 0 then
                            local allyEntity = GetMobByID(actorId + value)
                            if
                                allyEntity and
                                allyEntity:isAlive() and
                                allyEntity:checkDistance(actor) <= 8 and
                                allyEntity:getHPP() <= actionCondition
                            then
                                table.insert(actionList, { actionId, allyEntity, actionWeight })
                            end
                        end
                    end
                end
            end,

            -- For Self-targeted AoE cures.
            [xi.action.type.HEALING_FORCE_SELF] = function()
                -- Check self.
                if actor:getHPP() <= actionCondition then
                    table.insert(actionList, { actionId, actor, actionWeight })

                -- Check allies.
                else
                    if actionAllowAllies and optionalTargets then
                        local actorId = actor:getID()
                        for i = 1, #optionalTargets do
                            local value = optionalTargets[i]
                            if value ~= 0 then
                                local allyEntity = GetMobByID(actorId + value)
                                if
                                    allyEntity and
                                    allyEntity:isAlive() and
                                    allyEntity:checkDistance(actor) <= 8 and
                                    allyEntity:getHPP() <= actionCondition
                                then
                                    table.insert(actionList, { actionId, actor, actionWeight })
                                    break
                                end
                            end
                        end
                    end
                end
            end,

            [xi.action.type.HEALING_EFFECT] = function()
                -- Check self.
                if actor:hasStatusEffect(actionCondition) then
                    table.insert(actionList, { actionId, actor, actionWeight })
                end

                -- Check allies.
                if actionAllowAllies and optionalTargets then
                    local actorId = actor:getID()
                    for i = 1, #optionalTargets do
                        local value = optionalTargets[i]
                        if value ~= 0 then
                            local allyEntity = GetMobByID(actorId + value)
                            if
                                allyEntity and
                                allyEntity:isAlive() and
                                allyEntity:checkDistance(actor) <= 8 and
                                allyEntity:hasStatusEffect(actionCondition)
                            then
                                table.insert(actionList, { actionId, allyEntity, actionWeight })
                            end
                        end
                    end
                end
            end,

            [xi.action.type.ENHANCING_TARGET] = function()
                -- Check self.
                if not actor:hasStatusEffect(actionCondition) then
                    table.insert(actionList, { actionId, actor, actionWeight })
                end

                -- Check allies.
                if actionAllowAllies and optionalTargets then
                    local actorId = actor:getID()
                    for i = 1, #optionalTargets do
                        local value = optionalTargets[i]
                        if value ~= 0 then
                            local allyEntity = GetMobByID(actorId + value)
                            if
                                allyEntity and
                                allyEntity:isAlive() and
                                allyEntity:checkDistance(actor) <= 8 and
                                not allyEntity:hasStatusEffect(actionCondition)
                            then
                                table.insert(actionList, { actionId, allyEntity, actionWeight })
                            end
                        end
                    end
                end
            end,

            -- For Self-targeted AoE enhancements.
            [xi.action.type.ENHANCING_FORCE_SELF] = function()
                -- Check self.
                if not actor:hasStatusEffect(actionCondition) then
                    table.insert(actionList, { actionId, actor, actionWeight })

                -- Check allies.
                else
                    if actionAllowAllies and optionalTargets then
                        local actorId = actor:getID()
                        for i = 1, #optionalTargets do
                            local value = optionalTargets[i]
                            if value ~= 0 then
                                local allyEntity = GetMobByID(actorId + value)
                                if
                                    allyEntity and
                                    allyEntity:isAlive() and
                                    allyEntity:checkDistance(actor) <= 8 and
                                    not allyEntity:hasStatusEffect(actionCondition)
                                then
                                    table.insert(actionList, { actionId, actor, actionWeight })
                                    break
                                end
                            end
                        end
                    end
                end
            end,

            [xi.action.type.ENFEEBLING_TARGET] = function()
                if not actionTarget:hasStatusEffect(actionCondition) then
                    if
                        (actionCondition == xi.effect.SILENCE and xi.data.job.isInnateCaster(actionTarget)) or
                        actionCondition ~= xi.effect.SILENCE
                    then
                        table.insert(actionList, { actionId, actionTarget, actionWeight })
                    end
                end
            end,

            -- For self-targeted AoE enfeeblements. Use with care.
            [xi.action.type.ENFEEBLING_FORCE_SELF] = function()
                if not actionTarget:hasStatusEffect(actionCondition) then
                    if
                        (actionCondition == xi.effect.SILENCE and xi.data.job.isInnateCaster(actionTarget)) or
                        actionCondition ~= xi.effect.SILENCE
                    then
                        table.insert(actionList, { actionId, actor, actionWeight })
                    end
                end
            end,

            [xi.action.type.DRAIN_HP] = function()
                if not actionTarget:isUndead() then
                    if
                        actionCondition == nil or
                        (actionCondition and actor:getHPP() <= actionCondition)
                    then
                        table.insert(actionList, { actionId, actionTarget, actionWeight })
                    end
                end
            end,

            [xi.action.type.DRAIN_MP] = function()
                if
                    not actionTarget:isUndead() and
                    actionTarget:getMP() > 0
                then
                    if
                        actionCondition == nil or
                        (actionCondition and actor:getMPP() <= actionCondition)
                    then
                        table.insert(actionList, { actionId, actionTarget, actionWeight })
                    end
                end
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
