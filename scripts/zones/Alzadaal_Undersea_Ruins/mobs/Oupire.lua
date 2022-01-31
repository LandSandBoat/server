-----------------------------------
-- Area: Alzadaal Undersea Ruins
--   NM: Oupire
-----------------------------------
require("scripts/globals/hunts")
require("scripts/globals/titles")
require("scripts/globals/mobs")
-----------------------------------
local entity = {}

entity.onMobInitialize = function(mob)
end

entity.onMobSpawn = function(mob)
	mob:setMobMod(xi.mobMod.DRAW_IN, 1)
    mob:setMod(xi.mod.GRAVITYRES, 100)
    mob:setMod(xi.mod.LIGHT_RES, 54)
    mob:setMod(xi.mod.LIGHT_SDT, 54)
    mob:setMod(xi.mod.DARK_RES, 200)
    mob:setMod(xi.mod.DARK_SDT, 200)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 100)
    mob:setMod(xi.mod.LULLABYRES, 25)
    mob:setMod(xi.mod.SLEEPRES, 80)
    mob:setMod(xi.mod.SILENCERES, 100)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setLocalVar("spellstate", math.random(1,6))
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
        mob:setMod(xi.mod.DOUBLE_ATTACK, 80)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
        mob:setMod(xi.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 90 and mob:getHPP() > 80 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 60)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 40)
        mob:setMod(xi.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 80 and mob:getHPP() > 70 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 60)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 40)
        mob:setMod(xi.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 70 and mob:getHPP() > 60 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 40)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 60)
        mob:setMod(xi.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 60 and mob:getHPP() > 50 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 20)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 80)
        mob:setMod(xi.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 50 and mob:getHPP() > 40 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 100)
        mob:setMod(xi.mod.QUAD_ATTACK, 0)
    elseif mob:getHPP() <= 40 and mob:getHPP() > 30 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 80)
        mob:setMod(xi.mod.QUAD_ATTACK, 20)
    elseif mob:getHPP() <= 30 and mob:getHPP() > 20 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 50)
        mob:setMod(xi.mod.QUAD_ATTACK, 50)
    elseif mob:getHPP() <= 20 and mob:getHPP() > 10 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 30)
        mob:setMod(xi.mod.QUAD_ATTACK, 70)
    elseif mob:getHPP() <= 10 and mob:getHPP() > 0 then
        mob:setMod(xi.mod.DOUBLE_ATTACK, 0)
        mob:setMod(xi.mod.TRIPLE_ATTACK, 20)
        mob:setMod(xi.mod.QUAD_ATTACK, 80)
    end

    -- Phase Shifting

    if mob:getLocalVar("spellstate") == 1 then -- Fire
        mob:setSpellList(515)
        mob:addStatusEffect(xi.effect.BLAZE_SPIKES, 10, 0, 9000000)
        mob:addStatusEffect(xi.effect.ENFIRE, 10, 0, 9000000)
        mob:setMod(xi.mod.FIREDEF, 200)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
            mob:delStatusEffect(xi.effect.ICE_SPIKES)
        end
        if mob:hasStatusEffect(xi.effect.SHOCK_SPIKES) then
            mob:delStatusEffect(xi.effect.SHOCK_SPIKES)
        end
        mob:setMod(xi.mod.BLINK, 0)
        mob:setMod(xi.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(xi.mod.ICEDEF, 128)
        mob:setMod(xi.mod.WINDDEF, 128)
        mob:setMod(xi.mod.EARTHDEF, 128)
        mob:setMod(xi.mod.THUNDERDEF, 128)
        mob:setMod(xi.mod.WATERDEF, 128)
        mob:setMod(xi.mod.POISONRES, 50)
        mob:setMod(xi.mod.PARALYZERES, 50)
        mob:setMod(xi.mod.BINDRES, 50)
        mob:setMod(xi.mod.SLOWRES, 50)
        mob:setMod(xi.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(xi.effect.ENBLIZZARD) then
            mob:delStatusEffect(xi.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(xi.effect.ENAERO) then
            mob:delStatusEffect(xi.effect.ENAERO)
        end
        if mob:hasStatusEffect(xi.effect.ENSTONE) then
            mob:delStatusEffect(xi.effect.ENSTONE)
        end
        if mob:hasStatusEffect(xi.effect.ENTHUNDER) then
            mob:delStatusEffect(xi.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(xi.effect.ENWATER) then
            mob:delStatusEffect(xi.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 2 then -- Ice
        mob:setSpellList(510)
        mob:addStatusEffect(xi.effect.ICE_SPIKES, 10, 0, 9000000)
        mob:addStatusEffect(xi.effect.ENBLIZZARD, 10, 0, 9000000)
        mob:setMod(xi.mod.ICEDEF, 200)
        mob:setMod(xi.mod.BINDRES, 100)
        mob:setMod(xi.mod.PARALYZERES, 100)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
            mob:delStatusEffect(xi.effect.BLAZE_SPIKES)
        end
        if mob:hasStatusEffect(xi.effect.SHOCK_SPIKES) then
            mob:delStatusEffect(xi.effect.SHOCK_SPIKES)
        end
        mob:setMod(xi.mod.BLINK, 0)
        mob:setMod(xi.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(xi.mod.FIREDEF, 128)
        mob:setMod(xi.mod.WINDDEF, 128)
        mob:setMod(xi.mod.EARTHDEF, 128)
        mob:setMod(xi.mod.THUNDERDEF, 128)
        mob:setMod(xi.mod.WATERDEF, 128)
        mob:setMod(xi.mod.POISONRES, 50)
        mob:setMod(xi.mod.SLOWRES, 50)
        mob:setMod(xi.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(xi.effect.ENFIRE) then
            mob:delStatusEffect(xi.effect.ENFIRE)
        end
        if mob:hasStatusEffect(xi.effect.ENAERO) then
            mob:delStatusEffect(xi.effect.ENAERO)
        end
        if mob:hasStatusEffect(xi.effect.ENSTONE) then
            mob:delStatusEffect(xi.effect.ENSTONE)
        end
        if mob:hasStatusEffect(xi.effect.ENTHUNDER) then
            mob:delStatusEffect(xi.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(xi.effect.ENWATER) then
            mob:delStatusEffect(xi.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 3 then -- Wind
        mob:setSpellList(511)
        mob:setMod(xi.mod.BLINK, 1)
        mob:addStatusEffect(xi.effect.ENAERO, 10, 0, 9000000)
        mob:setMod(xi.mod.WINDDEF, 200)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
            mob:delStatusEffect(xi.effect.ICE_SPIKES)
        end
        if mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
            mob:delStatusEffect(xi.effect.SHOCK_SPIKES)
        end
        if mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
            mob:delStatusEffect(xi.effect.SHOCK_SPIKES)
        end
        mob:setMod(xi.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(xi.mod.FIREDEF, 128)
        mob:setMod(xi.mod.ICEDEF, 128)
        mob:setMod(xi.mod.EARTHDEF, 128)
        mob:setMod(xi.mod.THUNDERDEF, 128)
        mob:setMod(xi.mod.WATERDEF, 128)
        mob:setMod(xi.mod.POISONRES, 50)
        mob:setMod(xi.mod.PARALYZERES, 50)
        mob:setMod(xi.mod.BINDRES, 50)
        mob:setMod(xi.mod.SLOWRES, 50)
        mob:setMod(xi.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(xi.effect.ENBLIZZARD) then
            mob:delStatusEffect(xi.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(xi.effect.ENFIRE) then
            mob:delStatusEffect(xi.effect.ENFIRE)
        end
        if mob:hasStatusEffect(xi.effect.ENSTONE) then
            mob:delStatusEffect(xi.effect.ENSTONE)
        end
        if mob:hasStatusEffect(xi.effect.ENTHUNDER) then
            mob:delStatusEffect(xi.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(xi.effect.ENWATER) then
            mob:delStatusEffect(xi.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 4 then -- Earth
        mob:setSpellList(512)
        mob:addStatusEffect(xi.effect.ENSTONE, 10, 0, 9000000)
        mob:setMod(xi.mod.EARTHDEF, 200)
        mob:setMod(xi.mod.SLOWRES, 100)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
            mob:delStatusEffect(xi.effect.ICE_SPIKES)
        end
        if mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
            mob:delStatusEffect(xi.effect.SHOCK_SPIKES)
        end
        if mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
            mob:delStatusEffect(xi.effect.SHOCK_SPIKES)
        end
        mob:setMod(xi.mod.BLINK, 0)
        -- Remove Resistances
        mob:setMod(xi.mod.FIREDEF, 128)
        mob:setMod(xi.mod.ICEDEF, 128)
        mob:setMod(xi.mod.WINDDEF, 128)
        mob:setMod(xi.mod.THUNDERDEF, 128)
        mob:setMod(xi.mod.WATERDEF, 128)
        mob:setMod(xi.mod.POISONRES, 50)
        mob:setMod(xi.mod.PARALYZERES, 50)
        mob:setMod(xi.mod.BINDRES, 50)
        mob:setMod(xi.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(xi.effect.ENBLIZZARD) then
            mob:delStatusEffect(xi.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(xi.effect.ENAERO) then
            mob:delStatusEffect(xi.effect.ENAERO)
        end
        if mob:hasStatusEffect(xi.effect.ENFIRE) then
            mob:delStatusEffect(xi.effect.ENFIRE)
        end
        if mob:hasStatusEffect(xi.effect.ENTHUNDER) then
            mob:delStatusEffect(xi.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(xi.effect.ENWATER) then
            mob:delStatusEffect(xi.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 5 then -- Thunder
        mob:setSpellList(513)
        mob:addStatusEffect(xi.effect.SHOCK_SPIKES, 10, 0, 9000000)
        mob:addStatusEffect(xi.effect.ENTHUNDER, 10, 0, 9000000)
        mob:setMod(xi.mod.THUNDERDEF, 200)
        mob:setMod(xi.mod.STUNRES, 100)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
            mob:delStatusEffect(xi.effect.BLAZE_SPIKES)
        end
        if mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
            mob:delStatusEffect(xi.effect.ICE_SPIKES)
        end
        mob:setMod(xi.mod.BLINK, 0)
        mob:setMod(xi.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(xi.mod.FIREDEF, 128)
        mob:setMod(xi.mod.ICEDEF, 128)
        mob:setMod(xi.mod.WINDDEF, 128)
        mob:setMod(xi.mod.EARTHDEF, 128)
        mob:setMod(xi.mod.WATERDEF, 128)
        mob:setMod(xi.mod.POISONRES, 50)
        mob:setMod(xi.mod.PARALYZERES, 50)
        mob:setMod(xi.mod.BINDRES, 50)
        mob:setMod(xi.mod.SLOWRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(xi.effect.ENBLIZZARD) then
            mob:delStatusEffect(xi.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(xi.effect.ENAERO) then
            mob:delStatusEffect(xi.effect.ENAERO)
        end
        if mob:hasStatusEffect(xi.effect.ENSTONE) then
            mob:delStatusEffect(xi.effect.ENSTONE)
        end
        if mob:hasStatusEffect(xi.effect.ENFIRE) then
            mob:delStatusEffect(xi.effect.ENFIRE)
        end
        if mob:hasStatusEffect(xi.effect.ENWATER) then
            mob:delStatusEffect(xi.effect.ENWATER)
        end
    elseif mob:getLocalVar("spellstate") == 6 then -- Water
        mob:setSpellList(514)
        mob:addStatusEffect(xi.effect.ENWATER, 10, 0, 9000000)
        mob:setMod(xi.mod.WATERDEF, 200)
        mob:setMod(xi.mod.POISONRES, 100)
        -- Remove Defensive Buffs
        if mob:hasStatusEffect(xi.effect.BLAZE_SPIKES) then
            mob:delStatusEffect(xi.effect.BLAZE_SPIKES)
        end
        if mob:hasStatusEffect(xi.effect.ICE_SPIKES) then
            mob:delStatusEffect(xi.effect.ICE_SPIKES)
        end
        if mob:hasStatusEffect(xi.effect.SHOCK_SPIKES) then
            mob:delStatusEffect(xi.effect.SHOCK_SPIKES)
        end
        mob:setMod(xi.mod.BLINK, 0)
        mob:setMod(xi.mod.STONESKIN, 0)
        -- Remove Resistances
        mob:setMod(xi.mod.FIREDEF, 128)
        mob:setMod(xi.mod.ICEDEF, 128)
        mob:setMod(xi.mod.WINDDEF, 128)
        mob:setMod(xi.mod.EARTHDEF, 128)
        mob:setMod(xi.mod.THUNDERDEF, 128)
        mob:setMod(xi.mod.PARALYZERES, 50)
        mob:setMod(xi.mod.BINDRES, 50)
        mob:setMod(xi.mod.SLOWRES, 50)
        mob:setMod(xi.mod.STUNRES, 50)
        -- Remove Offensive Buffs
        if mob:hasStatusEffect(xi.effect.ENBLIZZARD) then
            mob:delStatusEffect(xi.effect.ENBLIZZARD)
        end
        if mob:hasStatusEffect(xi.effect.ENAERO) then
            mob:delStatusEffect(xi.effect.ENAERO)
        end
        if mob:hasStatusEffect(xi.effect.ENSTONE) then
            mob:delStatusEffect(xi.effect.ENSTONE)
        end
        if mob:hasStatusEffect(xi.effect.ENTHUNDER) then
            mob:delStatusEffect(xi.effect.ENTHUNDER)
        end
        if mob:hasStatusEffect(xi.effect.ENFIRE) then
            mob:delStatusEffect(xi.effect.ENFIRE)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == 2106 then -- Bloodrake (Fire)
        mob:setLocalVar("spellstate", 1)
    elseif skill:getID() == 2111 then -- Eternal Damnation (Ice)
        mob:setLocalVar("spellstate", 2)
    elseif skill:getID() == 2110 then -- Wings of Gehenna (Wind)
        mob:setLocalVar("spellstate", 3)
    elseif skill:getID() == 2109 then -- Heliovoid (Earth)
        mob:setLocalVar("spellstate", 4)
        mob:setMod(xi.mod.STONESKIN, 750)
    elseif skill:getID() == 2107 then -- Decollation (Thunder)
        mob:setLocalVar("spellstate", 5)
    elseif skill:getID() == 2108 then -- Nosferatu's Kiss (Water)
        mob:setLocalVar("spellstate", 6)
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