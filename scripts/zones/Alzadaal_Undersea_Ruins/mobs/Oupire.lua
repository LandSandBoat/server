-----------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Oupire
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/status")
require("scripts/globals/magic")
require("scripts/globals/mobs")
require("scripts/globals/npc_util")
-----------------------------------
local entity = {}

local function changePhase(mob, phase)
    -- Remove En- Buffs
    mob:delStatusEffect(xi.effect.ENSTONE)
    mob:delStatusEffect(xi.effect.ENWATER)
    mob:delStatusEffect(xi.effect.ENAERO)
    mob:delStatusEffect(xi.effect.ENFIRE)
    mob:delStatusEffect(xi.effect.ENBLIZZARD)
    mob:delStatusEffect(xi.effect.ENTHUNDER)

    -- Remove Spikes
    mob:delStatusEffect(xi.effect.BLAZE_SPIKES)
    mob:delStatusEffect(xi.effect.ICE_SPIKES)
    mob:delStatusEffect(xi.effect.SHOCK_SPIKES)

    -- Remove Defensive Buffs
    mob:setMod(xi.mod.BLINK, 0)
    mob:setMod(xi.mod.STONESKIN, 0)

    -- Remove Elemental Resistances
    mob:setMod(xi.mod.EARTH_MEVA, 128)
    mob:setMod(xi.mod.WATER_MEVA, 128)
    mob:setMod(xi.mod.WIND_MEVA, 128)
    mob:setMod(xi.mod.FIRE_MEVA, 128)
    mob:setMod(xi.mod.ICE_MEVA, 128)
    mob:setMod(xi.mod.THUNDER_MEVA, 128)

    -- Remove Status Resistances
    mob:setMod(xi.mod.BINDRES, 50)
    mob:setMod(xi.mod.PARALYZERES, 50)
    mob:setMod(xi.mod.POISONRES, 50)
    mob:setMod(xi.mod.SLOWRES, 50)
    mob:setMod(xi.mod.STUNRES, 50)

    -- Set Phase-Specific Mods
    if phase == 1 then -- Fire
        mob:setSpellList(460)
        mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 10, 0, 9000000)
        mob:addStatusEffect(xi.effect.ENFIRE, 10, 0, 9000000)
        mob:setMod(xi.mod.FIRE_MEVA, 200)
    elseif phase == 2 then -- Ice
        mob:setSpellList(461)
        mob:addStatusEffect(xi.effect.ICE_SPIKES, 10, 0, 9000000)
        mob:addStatusEffect(xi.effect.ENBLIZZARD, 10, 0, 9000000)
        mob:setMod(xi.mod.ICE_MEVA, 200)
        mob:setMod(xi.mod.BINDRES, 100)
        mob:setMod(xi.mod.PARALYZERES, 100)
    elseif phase == 3 then -- Wind
        mob:setSpellList(462)
        mob:setMod(xi.mod.BLINK, 1)
        mob:addStatusEffect(xi.effect.ENAERO, 10, 0, 9000000)
        mob:setMod(xi.mod.WIND_MEVA, 200)
    elseif phase == 4 then -- Earth
        mob:setSpellList(463)
        mob:addStatusEffect(xi.effect.ENSTONE, 10, 0, 9000000)
        mob:setMod(xi.mod.EARTH_MEVA, 200)
        mob:setMod(xi.mod.SLOWRES, 100)
        mob:setMod(xi.mod.STONESKIN, 750)
    elseif phase == 5 then -- Thunder
        mob:setSpellList(464)
        mob:addStatusEffect(xi.effect.SHOCK_SPIKES, 10, 0, 9000000)
        mob:addStatusEffect(xi.effect.ENTHUNDER, 10, 0, 9000000)
        mob:setMod(xi.mod.THUNDER_MEVA, 200)
        mob:setMod(xi.mod.STUNRES, 100)
    else -- Water
        mob:setSpellList(465)
        mob:addStatusEffect(xi.effect.ENWATER, 10, 0, 9000000)
        mob:setMod(xi.mod.WATER_MEVA, 200)
        mob:setMod(xi.mod.POISONRES, 100)
    end
end

local function attackPattern(mob, doubleRate, tripleRate, quadrupleRate)
    mob:setMod(xi.mod.DOUBLE_ATTACK, doubleRate)
    mob:setMod(xi.mod.TRIPLE_ATTACK, tripleRate)
    mob:setMod(xi.mod.QUAD_ATTACK, quadrupleRate)
end

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.LIGHT_MEVA, 54)
    mob:setMod(xi.mod.LIGHT_SDT, 54)
    mob:setMod(xi.mod.DARK_MEVA, 200)
    mob:setMod(xi.mod.DARK_SDT, 200)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    mob:setMod(xi.mod.LULLABYRES, 25)
    mob:setMod(xi.mod.SLEEPRES, 80)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)

    changePhase(mob, math.random(1,6))
end

entity.onAdditionalEffect = function(mob, target, damage)
    if mob:getLocalVar("spellstate") == 1 then -- Fire
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PLAGUE, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 2 then -- Ice
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PARALYZE, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 3 then -- Wind
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.SILENCE, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 4 then -- Earth
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.PETRIFY, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 5 then -- Thunder
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, {chance = 100})
    elseif mob:getLocalVar("spellstate") == 6 then -- Water
        return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.POISON, {chance = 100})
    end
end

entity.onMobFight = function(mob, target)
    -- Setup Attack Modifiers
    if mob:getHPP() <= 100 and mob:getHPP() >= 90 then
        attackPattern(mob, 80, 20, 0)
    elseif mob:getHPP() <= 90 and mob:getHPP() > 80 then
        attackPattern(mob, 60, 40, 0)
    elseif mob:getHPP() <= 80 and mob:getHPP() > 70 then
        attackPattern(mob, 50, 50, 0)
    elseif mob:getHPP() <= 70 and mob:getHPP() > 60 then
        attackPattern(mob, 40, 60, 0)
    elseif mob:getHPP() <= 60 and mob:getHPP() > 50 then
        attackPattern(mob, 20, 80, 0)
    elseif mob:getHPP() <= 50 and mob:getHPP() > 40 then
        attackPattern(mob, 0, 100, 0)
    elseif mob:getHPP() <= 40 and mob:getHPP() > 30 then
        attackPattern(mob, 0, 80, 20)
    elseif mob:getHPP() <= 30 and mob:getHPP() > 20 then
        attackPattern(mob, 0, 50, 50)
    elseif mob:getHPP() <= 20 and mob:getHPP() > 10 then
        attackPattern(mob, 0, 30, 70)
    elseif mob:getHPP() <= 10 and mob:getHPP() > 0 then
        attackPattern(mob, 0, 20, 80)
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 2106 then -- Bloodrake (Fire)
        changePhase(mob, 1)
    elseif skill:getID() == 2111 then -- Eternal Damnation (Ice)
        changePhase(mob, 2)
    elseif skill:getID() == 2110 then -- Wings of Gehenna (Wind)
        changePhase(mob, 3)
    elseif skill:getID() == 2109 then -- Heliovoid (Earth)
        changePhase(mob, 4)
    elseif skill:getID() == 2107 then -- Decollation (Thunder)
        changePhase(mob, 5)
    elseif skill:getID() == 2108 then -- Nosferatu's Kiss (Water)
        changePhase(mob, 6)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
    xi.hunts.checkHunt(mob, player, 478)
     player:addTitle(xi.title.OUPIRE_IMPALER)
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.random(14400, 18000)) -- 4 to 5 hours
end

return entity
