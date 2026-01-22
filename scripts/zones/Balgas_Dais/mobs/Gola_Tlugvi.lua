-----------------------------------
-- Area: Balga's Dais
--  Mob: Gola Tlugvi (DRK) "Winter Tree"
-- BCNM: Season's Greetings
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.NO_LINK, 1)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DARK_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 7)
    mob:setMod(xi.mod.SLOW_RES_RANK, 7)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 7)
    mob:setMod(xi.mod.BIND_RES_RANK, 7)
    mob:setMod(xi.mod.BLIND_RES_RANK, 7)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('bloodWeaponTime', 0)
end

-- If it has been more than 2 minutes since Blood Weapon was used, gain a significant damage boost.
entity.onMobFight = function(mob, target)
    if mob:getMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER) == 250 then
        return
    end

    local bloodWeaponTime = mob:getLocalVar('bloodWeaponTime')

    if
        bloodWeaponTime > 0 and
        GetSystemTime() > bloodWeaponTime + 120
    then
        mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 250)
    end
end

-- Has additional effect: TP Drain (15% chance, drains 50-1100 TP)
entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.TP_DRAIN, { chance = 15, power = math.random (50, 1100) })
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.DRILL_BRANCH
end

-- If Blood Weapon is used, the Spring tree (Gilagoge Tlugvi) attacks.
entity.onMobWeaponSkill = function(target, mob, skill)
    local skillID = skill:getID()
    local battlefield = mob:getBattlefield()

    if not battlefield then
        return
    end

    if skillID == xi.mobSkill.BLOOD_WEAPON_1 then
        local currentTime = GetSystemTime()
        mob:setLocalVar('bloodWeaponTime', currentTime)
        local baseId = mob:getID()
        local springTree = GetMobByID(baseId - 3)

        if springTree and springTree:isAlive() then
            local currentTarget = mob:getTarget()
            if not currentTarget then
                return
            end

            springTree:updateEnmity(currentTarget)
        end
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [ 1] = { xi.magic.spell.DRAIN,        target, false, xi.action.type.DRAIN_HP,          nil,                0, 100 },
        [ 2] = { xi.magic.spell.ASPIR,        target, false, xi.action.type.DRAIN_MP,          nil,                0, 100 },
        [ 3] = { xi.magic.spell.STUN,         mob,    false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.STUN,     0, 100 },
        [ 4] = { xi.magic.spell.ABSORB_TP,    mob,    false, xi.action.type.ENFEEBLING_EFFECT, nil,                0, 100 },
        [ 5] = { xi.magic.spell.ABSORB_STR,   mob,    false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.STR_DOWN, 0, 100 },
        [ 6] = { xi.magic.spell.ABSORB_DEX,   mob,    false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.DEX_DOWN, 0, 100 },
        [ 7] = { xi.magic.spell.ABSORB_VIT,   mob,    false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.VIT_DOWN, 0, 100 },
        [ 8] = { xi.magic.spell.ABSORB_AGI,   mob,    false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.AGI_DOWN, 0, 100 },
        [ 9] = { xi.magic.spell.ABSORB_INT,   mob,    false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.INT_DOWN, 0, 100 },
        [10] = { xi.magic.spell.ABSORB_MND,   mob,    false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.MND_DOWN, 0, 100 },
        [11] = { xi.magic.spell.ABSORB_CHR,   mob,    false, xi.action.type.ENFEEBLING_EFFECT, xi.effect.CHR_DOWN, 0, 100 },
    }
    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
