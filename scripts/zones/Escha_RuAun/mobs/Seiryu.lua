-----------------------------------
-- CatsEyeXI SKY 2.0
-- Area: Escha RuAun
-- NM: Seiryu
-- Mobid: 
-- weak to ice. strong vs fire and wind
-- todo listener; bene on any player death
-----------------------------------
local ID = require("scripts/zones/RuAun_Gardens/IDs")
mixins = {
require("scripts/mixins/job_special"),
require("scripts/mixins/rage")}
require("scripts/globals/mobs")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/titles")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.TELEPORT_CD, 15)
    mob:setMobMod(xi.mobMod.TELEPORT_START, 988)
    mob:setMobMod(xi.mobMod.TELEPORT_END, 989)
    mob:setMobMod(xi.mobMod.TELEPORT_TYPE, 1)
    mob:setMod(xi.mod.SILENCERES, 10000)
    mob:setMod(xi.mod.BINDRES, 10000)
    mob:setMod(xi.mod.GRAVITYRES, 10000)
    mob:setMod(xi.mod.SLEEPRES, 10000)
    mob:setMod(xi.mod.LULLABYRES, 10000)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    mob:addStatusEffect(xi.effect.REGAIN, 30, 3, 0)
    mob:addStatusEffect(xi.effect.REGEN, 30, 3, 0)
    mob:addStatusEffect(xi.effect.REFRESH, 50, 3, 0)
    mob:setMod(xi.mod.MOVE, 25)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 300)
    --[[mob:setMod(xi.mod.DOUBLE_ATTACK, 10)
    mob:setMod(xi.mod.EARTH_MEVA, 200)
    mob:setMod(xi.mod.DARK_MEVA, 200)
    mob:setMod(xi.mod.LIGHT_MEVA, 200)
    mob:setMod(xi.mod.FIRE_MEVA, 200)
    mob:setMod(xi.mod.WATER_MEVA, 300)
    mob:setMod(xi.mod.THUNDER_MEVA, 150)
    mob:setMod(xi.mod.ICE_MEVA, 150)
    mob:setMod(xi.mod.WIND_MEVA, 200)
    mob:setMod(xi.mod.EARTH_SDT, 200)
    mob:setMod(xi.mod.DARK_SDT, 200)
    mob:setMod(xi.mod.LIGHT_SDT, 200)
    mob:setMod(xi.mod.FIRE_SDT, 200)
    mob:setMod(xi.mod.WATER_SDT, 300)
    mob:setMod(xi.mod.THUNDER_SDT, 150)
    mob:setMod(xi.mod.ICE_SDT, 150)
    mob:setMod(xi.mod.WIND_SDT, 200)
    mob:addMod(xi.mod.ATT, 200)
    mob:addMod(xi.mod.MDEF, 200)
    mob:addMod(xi.mod.DEF, 175)
    mob:addMod(xi.mod.STR, 50)
    mob:addMod(xi.mod.VIT, 30)
    mob:addMod(xi.mod.INT, 70)
    mob:addMod(xi.mod.MND, 30)
    mob:addMod(xi.mod.CHR, 20)
    mob:addMod(xi.mod.AGI, 30)
    mob:addMod(xi.mod.DEX, 40)
    mob:addMod(xi.mod.MATT, 250)
    mob:addMod(xi.mod.MACC, 250)]]--
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMod(xi.mod.WIND_ABSORB, 100)
    mob:setMobMod(xi.mobMod.AUTO_SPIKES, 1)
    mob:addStatusEffect(xi.effect.ICE_SPIKES, 50, 0, 0)
    mob:addMod(xi.mod.UFASTCAST, 150)
    mob:setSpellList(231)
	mob:setDropID(3993)
end

entity.onAdditionalEffect = function(mob, target, damage)
    if math.random() > .5 then
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.ENAERO, {chance = 75})
    else
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SILENCE, {chance = 25})
    end
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar("[rage]timer", 1800) -- 30 minutes
-- Every weaponskill is followed up with Wind Wall.	
    mob:addListener("WEAPONSKILL_USE", "WIND_WALL_BONUS", function(mobArg, target, wsid, tp, action)
        if 
	        wsid == 673
        then
            mob:useMobAbility(815)
        elseif
            wsid == 814
        then
            mob:useMobAbility(815)
        elseif
            wsid == 816
        then
            mob:useMobAbility(815)
        elseif
            wsid == 817
        then
            mob:useMobAbility(815)
        elseif
            wsid == 818
        then
            mob:useMobAbility(815)
        elseif
            wsid == 821
        then
            mob:useMobAbility(815)
        elseif
            wsid == 986
        then
            mob:useMobAbility(815)
        end
    end)
end

entity.onMobFight = function(mob, target)
    local lifePercent = mob:getHPP()
    local phase = mob:getLocalVar("phase")
    local hateReset = mob:getLocalVar("hateReset")
    local phaseSKILL = mob:getLocalVar("phaseSKILL")

    local alliance = target:getAlliance()

    for _, member in pairs(alliance) do
        if
            mob:getMobMod(xi.mobMod.TELEPORT_START) and hateReset == 0 then
            mob:setLocalVar("hateReset", 1)
            mob:updateEnmity(math.random(member))
        end
    end
-- HP phases defined here
    if lifePercent <= 100 and lifePercent >= 81 then
        mob:setLocalVar("phase", 1)
    end

    if lifePercent <= 80 and lifePercent >= 61 then
        mob:setLocalVar("phase", 2)
        mob:setLocalVar("hateReset", 0)
    end

    if lifePercent <= 60 and lifePercent >= 41 then
        mob:setLocalVar("phase", 1)
        mob:setLocalVar("hateReset", 0)
    end

    if lifePercent <= 40 and lifePercent >= 21 then
        mob:setLocalVar("phase", 2)
        mob:setLocalVar("hateReset", 0)
    end

    if lifePercent <= 20 and lifePercent >= 1 then
        mob:setLocalVar("phase", 1)
        mob:setLocalVar("hateReset", 0)
    end
-- Phase 1 takes magic damage and absorbs melee damage.
    if mob:getLocalVar("phase") == 1 then
        mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
        mob:delStatusEffect(xi.effect.MIGHTY_STRIKES)
        mob:addStatusEffect(xi.effect.HUNDRED_FISTS, 1, 0, 0)
        mob:addStatusEffectEx(xi.effect.PHYSICAL_SHIELD, 1, 2, 0, 0)
-- Phase 2 takes melee dmg and is immune to magic damage.
    elseif mob:getLocalVar("phase") == 2 then
        mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
        mob:delStatusEffect(xi.effect.HUNDRED_FISTS)
        mob:addStatusEffect(xi.effect.MIGHTY_STRIKES, 1, 0, 0)
        mob:addStatusEffectEx(xi.effect.MAGIC_SHIELD, 1, 1, 0, 0)
    end
-- Use a special abilty on phase changes
    if phaseSKILL == 0 and mob:getLocalVar("phase") == 1 then
        mob:useMobAbility(673) --Dark Nova
        mob:setLocalVar("phaseSKILL", 1)
    end

    if phaseSKILL == 1 and mob:getLocalVar("phase") == 2 then
        mob:useMobAbility(986) --Vortex
        mob:setLocalVar("phaseSKILL", 0)
    end

    mob:addListener("ATTACKED", "DEATH", function(mobArg, player, action)
        local alliance = player:getAlliance()
        for _, member in pairs(alliance) do
            if member:getZoneID() == player:getZoneID() and member:isDead() and mobArg:getLocalVar("bene") == 0 then
                mobArg:setLocalVar("bene", 1)
                mobArg:useMobAbility(689)
            end
        end
    end)
end
-- Modify these spells to AOE and 30 yalms
entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == 208 then -- Tornado
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setMPCost(1)
    end

    if spell:getID() == 245 then -- Drain
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(30)
        spell:setMPCost(1)
    end
end

entity.onMobDespawn = function(mob)
    mob:resetLocalVars()
    mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
    mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
end

entity.onMobDeath = function(mob, player, isKiller)
    mob:resetLocalVars()
    player:addTitle(xi.title.SEIRYU_CLIPPER)
    mob:delStatusEffect(xi.effect.MAGIC_SHIELD)
    mob:delStatusEffect(xi.effect.PHYSICAL_SHIELD)
end

return entity
