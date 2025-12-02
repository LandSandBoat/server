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
