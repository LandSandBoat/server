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
entity.onMobWeaponSkill = function(mob, target, skill, action)
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
        [ 1] = { spellId = xi.magic.spell.DRAIN,              evaluateUndead = true },
        [ 2] = { spellId = xi.magic.spell.ASPIR,     mp = 1,  evaluateUndead = true },
        [ 3] = { spellId = xi.magic.spell.STUN                                      },
        [ 4] = { spellId = xi.magic.spell.ABSORB_TP, tp = 500                       },
        [ 5] = { spellId = xi.magic.spell.ABSORB_STR                                },
        [ 6] = { spellId = xi.magic.spell.ABSORB_DEX                                },
        [ 7] = { spellId = xi.magic.spell.ABSORB_VIT                                },
        [ 8] = { spellId = xi.magic.spell.ABSORB_AGI                                },
        [ 9] = { spellId = xi.magic.spell.ABSORB_INT                                },
        [10] = { spellId = xi.magic.spell.ABSORB_MND                                },
        [11] = { spellId = xi.magic.spell.ABSORB_CHR                                },
    }

    return xi.combat.behavior.chooseSpell(mob, target, spellList, nil, nil)
end

return entity
