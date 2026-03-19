-----------------------------------
-- Area: The Ashu Talif (Against All Odds)
--  Mob: Gowam
-----------------------------------
local ID = zones[xi.zone.THE_ASHU_TALIF]
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
    mob:setBehavior(xi.behavior.NO_DESPAWN)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 10)
    mob:setMod(xi.mod.UFASTCAST, 50)
    mob:setMod(xi.mod.ACC, 296)
    mob:setMobMod(xi.mobMod.DETECTION, 0x002)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 10)
end

entity.onMobEngage = function(mob)
    mob:setMagicCastingEnabled(true) -- Gowam does not self buff before engaging
    mob:setMod(xi.mod.REGAIN, 75)
end

entity.onMobFight = function(mob, target)
    -- Handle Azure Lore
    if mob:hasStatusEffect(xi.effect.AZURE_LORE) then
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 0)
    else
        mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    end

    -- Early return: No instance
    local instance = mob:getInstance()
    if not instance then
        return
    end

    -- Early return: No partner entity
    local yazquhl = GetMobByID(ID.mob.YAZQUHL, instance)
    if not yazquhl then
        return
    end

    -- Handle Skillchain opener.
    local yazquhlTP = yazquhl:getTP()
    if
        yazquhlTP >= 1000 and
        mob:getTP() > yazquhlTP and
        not xi.combat.behavior.isEntityBusy(mob)
    then
        mob:useMobAbility()
    end

    -- Handle Skillchain closer.
    if instance:getLocalVar('scReadyYazquhl') ~= 1 then
        return
    end

    instance:setLocalVar('scReadyYazquhl', 0)

    local scTarget = GetPlayerByID(instance:getLocalVar('scTargetYazquhl'))
    if not scTarget then
        return
    end

    mob:timer(4000, function(gowamMob)
        if
            gowamMob:getTP() < 1000 or
            not scTarget or
            scTarget:isDead() or
            gowamMob:checkDistance(scTarget) >= 25
        then
            gowamMob:setMobAbilityEnabled(true)
            gowamMob:setMagicCastingEnabled(true)
            return
        end

        gowamMob:useMobAbility(xi.mobSkill.VORPAL_BLADE_1, scTarget)

        -- Only add Emnity if the skillchain closer target is different than its current target
        if
            yazquhl:isAlive() and
            yazquhl and scTarget ~= target
        then
            gowamMob:addEnmity(scTarget, yazquhl:getCE(scTarget), yazquhl:getVE(scTarget))
        end
    end)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpTable =
    {
        xi.mobSkill.FAST_BLADE_1,
        xi.mobSkill.BURNING_BLADE_1,
        xi.mobSkill.RED_LOTUS_BLADE_1,
        xi.mobSkill.SHINING_BLADE_1,
        xi.mobSkill.SERAPH_BLADE_1,
        xi.mobSkill.CIRCLE_BLADE_1,
    }

    local instance = mob:getInstance()
    if not instance then
        return
    end

    local yazquhl = GetMobByID(ID.mob.YAZQUHL, instance)
    if not yazquhl then
        return
    end

    if
        yazquhl:isDead() or
        yazquhl:getTP() < 1000 or
        mob:checkDistance(yazquhl) >= 25
    then
        table.insert(tpTable, xi.mobSkill.FLAT_BLADE_1)
        table.insert(tpTable, xi.mobSkill.VORPAL_BLADE_1)
    end

    return tpTable[math.random(1, #tpTable)]
end

entity.onMobWeaponSkill = function(mob, target)
    local instance = mob:getInstance()
    if not instance then
        return
    end

    mob:setMobAbilityEnabled(true)
    mob:setMagicCastingEnabled(true)

    local yazquhl = GetMobByID(ID.mob.YAZQUHL, instance)
    if
        yazquhl and
        yazquhl:isAlive() and
        mob:checkDistance(yazquhl) < 25
    then
        yazquhl:setMobAbilityEnabled(false)
        instance:setLocalVar('scReadyGowam', 1)
        instance:setLocalVar('scTargetGowam', target:getID())
    end
end

entity.onMobSpellChoose = function(mob, target, spell)
    local spellList =
    {
        [1]  = { xi.magic.spell.BAD_BREATH,       target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [2]  = { xi.magic.spell.BLOOD_SABER,      target, false, xi.action.type.DRAIN_HP,             nil,                    0, 100 },
        [3]  = { xi.magic.spell.FEATHER_TICKLE,   target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [4]  = { xi.magic.spell.FRENETIC_RIP,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [5]  = { xi.magic.spell.HYSTERIC_BARRAGE, target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [6]  = { xi.magic.spell.MAELSTROM,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [7]  = { xi.magic.spell.METALLIC_BODY,    mob,    false, xi.action.type.ENHANCING_FORCE_SELF, xi.effect.STONESKIN,    0, 100 },
        [8]  = { xi.magic.spell.MP_DRAINKISS,     target, false, xi.action.type.DRAIN_MP,             nil,                    0, 100 },
        [9]  = { xi.magic.spell.POLLEN,           mob,    false, xi.action.type.HEALING_FORCE_SELF,   100,                    0, 100 },
        [10] = { xi.magic.spell.SCREWDRIVER,      target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [11] = { xi.magic.spell.SICKLE_SLASH,     target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [12] = { xi.magic.spell.SPINAL_CLEAVE,    target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [13] = { xi.magic.spell.STINKING_GAS,     target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.VIT_DOWN,     0, 100 },
        [14] = { xi.magic.spell.TAIL_SLAP,        target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [15] = { xi.magic.spell.VORACIOUS_TRUNK,  target, false, xi.action.type.DAMAGE_TARGET,        nil,                    0, 100 },
        [16] = { xi.magic.spell.YAWN,             target, false, xi.action.type.ENFEEBLING_TARGET,    xi.effect.SLEEP_I,      0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

entity.onMobDeath = function(mob, player, optParams)
    mob:showText(mob, ID.text.GOWAM_DEATH)
end

entity.onMobDespawn = function(mob)
    local instance = mob:getInstance()
    if instance then
        instance:setProgress(instance:getProgress() + 1)
    end
end

return entity
