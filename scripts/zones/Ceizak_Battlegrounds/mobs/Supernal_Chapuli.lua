-----------------------------------
-- Area: Ceizak Battlegrounds
-- NM: Supernal Chapuli
-- !pos 277 0 -129 261
-- !additem 6012
-----------------------------------
---@type TMobEntity
local entity = {}

local orthoID = 2949 -- Orthopterror
local natMedID = 2945 -- Nature's Meditation
local invulnerabilityDuration = 3 -- Duration of invulnerability in seconds
local damageReductionValue = -10000 -- Set to a very high negative value for invulnerability

local function handleWeaponSkillUse(mob, target, weaponSkill)
    if weaponSkill ~= natMedID then
        mob:setMod(xi.mod.UDMGPHYS, damageReductionValue)
        mob:setMod(xi.mod.UDMGRANGE, damageReductionValue)
        mob:setMod(xi.mod.UDMGMAGIC, damageReductionValue)
        mob:setMod(xi.mod.UDMGBREATH, damageReductionValue)

        mob:timer(invulnerabilityDuration * 1000, function()
            mob:setMod(xi.mod.UDMGPHYS, 0)
            mob:setMod(xi.mod.UDMGRANGE, 0)
            mob:setMod(xi.mod.UDMGMAGIC, 0)
            mob:setMod(xi.mod.UDMGBREATH, 0)
        end)
    end
end

local function handleOrthop(mob)
    if mob:hasStatusEffect(xi.effect.ATTACK_BOOST) then
        local tp = mob:getTP()
        if tp >= 1000 then
            mob:useMobAbility(orthoID)
            mob:setTP(0) -- Reset TP after using the ability
        end
    end
end

entity.onMobFight = function(mob, target)
    if mob:getHPP() <= 50 then
        mob:setMobMod(xi.mobMod.SPELL_LIST, 509)
    else
        mob:setMobMod(xi.mobMod.SPELL_LIST, 508)
    end
end

entity.onMobSpawn = function(mob)
    mob:addListener('WEAPONSKILL_USE', 'MOB_INVULNERABILITY', function(mobArg, target, weaponSkill)
        handleWeaponSkillUse(mobArg, target, weaponSkill)
    end)

    mob:addListener('COMBAT_TICK', 'CHECK_MEDITATION_EFFECT', function(mobArg, target)
        handleOrthop(mobArg)
    end)
end

entity.onMobDeath = function(mob)
end

return entity
