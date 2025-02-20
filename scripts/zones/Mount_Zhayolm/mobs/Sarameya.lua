-----------------------------------
-- Area: Mount Zhayolm
--   NM: Sarameya
-- !pos 322 -14 -581 61
-- Spawned with Buffalo Corpse: !additem 2583
-- Wiki: http://ffxiclopedia.wikia.com/wiki/Sarameya
-- TODO: PostAIRewrite: Code the Howl effect and gradual resists.
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 50)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
end

entity.onMobSpawn = function(mob)
    mob:addMod(xi.mod.MEVA, 95)
    mob:addMod(xi.mod.MDEF, 30)
    mob:addMod(xi.mod.SILENCE_MEVA, 20)
    mob:addMod(xi.mod.GRAVITY_MEVA, 20)
    mob:addMod(xi.mod.LULLABY_MEVA, 30)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
end

entity.onMobRoam = function(mob)
end

entity.onMobFight = function(mob, target)
    local hpp = mob:getHPP()
    local useChainspell = false

    if hpp < 90 and mob:getLocalVar('chainspell89') == 0 then
        mob:setLocalVar('chainspell89', 1)
        useChainspell = true
    elseif hpp < 70 and mob:getLocalVar('chainspell69') == 0 then
        mob:setLocalVar('chainspell69', 1)
        useChainspell = true
    elseif hpp < 50 and mob:getLocalVar('chainspell49') == 0 then
        mob:setLocalVar('chainspell49', 1)
        useChainspell = true
    elseif hpp < 30 and mob:getLocalVar('chainspell29') == 0 then
        mob:setLocalVar('chainspell29', 1)
        useChainspell = true
    elseif hpp < 10 and mob:getLocalVar('chainspell9') == 0 then
        mob:setLocalVar('chainspell9', 1)
        useChainspell = true
    end

    if useChainspell then
        mob:useMobAbility(692) -- Chainspell
        mob:setMobMod(xi.mobMod.GA_CHANCE, 100)
    end

    -- Spams TP moves and -ga spells
    if mob:hasStatusEffect(xi.effect.CHAINSPELL) then
        mob:setTP(2000)
    else
        if mob:getMobMod(xi.mobMod.GA_CHANCE) == 100 then
            mob:setMobMod(xi.mobMod.GA_CHANCE, 50)
        end
    end

    -- Regens 1% of his HP a tick with Blaze Spikes on
    if mob:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
        mob:setMod(xi.mod.REGEN, math.floor(mob:getMaxHP() / 100))
    else
        if mob:getMod(xi.mod.REGEN) > 0 then
            mob:setMod(xi.mod.REGEN, 0)
        end
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, { chance = 40, power = 50 })
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
