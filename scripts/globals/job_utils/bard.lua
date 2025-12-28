-----------------------------------
-- Bard Job Utilities
-----------------------------------
xi = xi or {}
xi.job_utils = xi.job_utils or {}
xi.job_utils.bard = xi.job_utils.bard or {}

-----------------------------------
-- Ability Check Functions
-----------------------------------
xi.job_utils.bard.checkSoulVoice = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

xi.job_utils.bard.checkClarionCall = function(player, target, ability)
    ability:setRecast(math.max(0, ability:getRecast() - player:getMod(xi.mod.ONE_HOUR_RECAST) * 60))

    return 0, 0
end

-----------------------------------
-- Ability Use Functions
-----------------------------------
xi.job_utils.bard.useSoulVoice = function(player, target, ability)
    player:addStatusEffect(xi.effect.SOUL_VOICE, 1, 0, 180)

    return xi.effect.SOUL_VOICE
end

xi.job_utils.bard.usePianissimo = function(player, target, ability)
    player:addStatusEffect(xi.effect.PIANISSIMO, 0, 0, 60)

    return xi.effect.PIANISSIMO
end

xi.job_utils.bard.useNightingale = function(player, target, ability)
    player:addStatusEffect(xi.effect.NIGHTINGALE, 0, 0, 60)

    return xi.effect.NIGHTINGALE
end

xi.job_utils.bard.useTroubadour = function(player, target, ability)
    player:addStatusEffect(xi.effect.TROUBADOUR, 0, 0, 60)

    return xi.effect.TROUBADOUR
end

xi.job_utils.bard.useTenuto = function(player, target, ability)
    -- TODO: Implement this ability
    player:addStatusEffect(xi.effect.TENUTO, 0, 0, 60)

    return xi.effect.TENUTO
end

xi.job_utils.bard.useMarcato = function(player, target, ability)
    player:addStatusEffect(xi.effect.MARCATO, 50, 0, 60)

    return xi.effect.MARCATO
end

xi.job_utils.bard.useClarionCall = function(player, target, ability)
    player:addStatusEffect(xi.effect.CLARION_CALL, 10, 0, 180)

    return xi.effect.CLARION_CALL
end
