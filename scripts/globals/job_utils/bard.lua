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
    player:addStatusEffect(xi.effect.SOUL_VOICE, { power = 1, duration = 180, origin = player })

    return xi.effect.SOUL_VOICE
end

xi.job_utils.bard.usePianissimo = function(player, target, ability)
    -- Power: song cast time reduction (%)
    player:addStatusEffect(xi.effect.PIANISSIMO, { power = 50, duration = 60, origin = player })

    return xi.effect.PIANISSIMO
end

xi.job_utils.bard.useNightingale = function(player, target, ability, action)
    -- Power: instant song cast chance (%)
    local power = math.max(0, player:getMerit(xi.merit.NIGHTINGALE) - 25)

    player:addStatusEffect(xi.effect.NIGHTINGALE, { power = power, duration = 60, origin = player })

    return xi.effect.NIGHTINGALE
end

xi.job_utils.bard.useTroubadour = function(player, target, ability, action)
    -- Power: song magic accuracy
    local power = math.max(0, 64 * (player:getMerit(xi.merit.TROUBADOUR) / 25 - 1))

    player:addStatusEffect(xi.effect.TROUBADOUR, { power = power, duration = 60, origin = player })

    return xi.effect.TROUBADOUR
end

xi.job_utils.bard.useTenuto = function(player, target, ability)
    -- TODO: Implement this ability
    player:addStatusEffect(xi.effect.TENUTO, { duration = 60, origin = player })

    return xi.effect.TENUTO
end

xi.job_utils.bard.useMarcato = function(player, target, ability)
    player:addStatusEffect(xi.effect.MARCATO, { power = 50, duration = 60, origin = player })

    return xi.effect.MARCATO
end

xi.job_utils.bard.useClarionCall = function(player, target, ability)
    player:addStatusEffect(xi.effect.CLARION_CALL, { power = 10, duration = 180, origin = player })

    return xi.effect.CLARION_CALL
end
