-----------------------------------
-- Area: Mount Zhayolm
-- NM: Sarameya
-- !pos 322 -14 -581 61
-- Spawned with Buffalo Corpse: !additem 2583
-- Weak to water elemental damage
-----------------------------------
mixins = { require("scripts/mixins/rage") }
require("scripts/globals/magic")
require("scripts/globals/msg")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.GA_CHANCE, 50)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addMod(xi.mod.MDEF, -12)
    mob:addMod(xi.mod.DEF, 50)
    mob:addMod(xi.mod.STR, 40)
    mob:addMod(xi.mod.VIT, 20)
    mob:addMod(xi.mod.INT, 10)
    mob:addMod(xi.mod.MND, 10)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 20)
    mob:addMod(xi.mod.DEX, 40)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EARTH_MEVA, 170)
    mob:setMod(xi.mod.DARK_MEVA, 125)
    mob:setMod(xi.mod.LIGHT_MEVA, 128)
    mob:setMod(xi.mod.FIRE_MEVA, 250)
    mob:setMod(xi.mod.THUNDER_MEVA, 170)
    mob:setMod(xi.mod.ICE_MEVA, 200)
    mob:setMod(xi.mod.WIND_MEVA, 170)
    mob:setMod(xi.mod.EARTH_SDT, 170)
    mob:setMod(xi.mod.DARK_SDT, 250)
    mob:setMod(xi.mod.LIGHT_SDT, 128)
    mob:setMod(xi.mod.FIRE_SDT, 250)
    mob:setMod(xi.mod.THUNDER_SDT, 170)
    mob:setMod(xi.mod.ICE_SDT, 200)
    mob:setMod(xi.mod.WIND_SDT, 170)
    mob:setMod(xi.mod.FIRE_ABSORB, 100)
    mob:setMod(xi.mod.FASTCAST, 10)
    mob:addStatusEffect(xi.effect.REGAIN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 5, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:addMod(xi.mod.MOVE, 12)
    mob:setLocalVar("[rage]timer", 3600) -- 60 minutes
end

entity.onMobRoam = function(mob)
end

entity.onMobFight = function(mob, target)
    local hpp = mob:getHPP()
    local useChainspell = false

    if hpp < 90 and mob:getLocalVar("chainspell89") == 0 then
        mob:setLocalVar("chainspell89", 1)
        useChainspell = true
    elseif hpp < 70 and mob:getLocalVar("chainspell69") == 0 then
        mob:setLocalVar("chainspell69", 1)
        useChainspell = true
    elseif hpp < 50 and mob:getLocalVar("chainspell49") == 0 then
        mob:setLocalVar("chainspell49", 1)
        useChainspell = true
    elseif hpp < 30 and mob:getLocalVar("chainspell29") == 0 then
        mob:setLocalVar("chainspell29", 1)
        useChainspell = true
    elseif hpp < 10 and mob:getLocalVar("chainspell9") == 0 then
        mob:setLocalVar("chainspell9", 1)
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
