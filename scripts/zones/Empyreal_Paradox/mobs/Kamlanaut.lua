-----------------------------------
-- Area: Emperial Paradox
--  Mob: Kam'lanaut
-- Apocalypse Nigh Final Fight
-----------------------------------
---@type TMobEntity
local entity = {}

local skillToAbsorb =
{
    [xi.mobSkill.FIRE_BLADE_1     ] = xi.mod.FIRE_ABSORB,
    [xi.mobSkill.FROST_BLADE_1    ] = xi.mod.ICE_ABSORB,
    [xi.mobSkill.WIND_BLADE_1     ] = xi.mod.WIND_ABSORB,
    [xi.mobSkill.EARTH_BLADE_1    ] = xi.mod.EARTH_ABSORB,
    [xi.mobSkill.LIGHTNING_BLADE_1] = xi.mod.LTNG_ABSORB,
    [xi.mobSkill.WATER_BLADE_1    ] = xi.mod.WATER_ABSORB,
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.TERROR)
    mob:setMod(xi.mod.BIND_RES_RANK, 11)
    mob:setMod(xi.mod.BLIND_RES_RANK, 11)
    mob:setMod(xi.mod.LIGHT_SLEEP_RES_RANK, 11)
    mob:setMod(xi.mod.PARALYZE_RES_RANK, 11)
    mob:setMod(xi.mod.POISON_RES_RANK, 11)
    mob:setMod(xi.mod.SLOW_RES_RANK, 11)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 10)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('nextEnSkill', GetSystemTime() + 10)
end

entity.onMobFight = function(mob, target)
    if xi.combat.behavior.isEntityBusy(mob) then
        return
    end

    if GetSystemTime() > mob:getLocalVar('nextEnSkill') then
        local skill = math.random(xi.mobSkill.FIRE_BLADE_1, xi.mobSkill.WATER_BLADE_1)
        mob:useMobAbility(skill)
        mob:setLocalVar('nextEnSkill', GetSystemTime() + 30)
    end
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpList =
    {
        xi.mobSkill.GREAT_WHEEL_1,
        xi.mobSkill.LIGHT_BLADE_1,
    }

    return tpList[math.random(1, #tpList)]
end

entity.onMobWeaponSkill = function(target, mob, skill)
    local skillId = skill:getID()
    local absorbId = skillToAbsorb[skillId]

    if absorbId then
        -- ----------------------------------------------------------------------
        -- when using en-spell weapon skill, absorb damage of that element type
        -- ----------------------------------------------------------------------

        -- remove previous absorb mod, if set
        local previousAbsorb = mob:getLocalVar('currentAbsorb')

        if previousAbsorb > 0 then
            mob:setMod(previousAbsorb, 0)
        end

        -- add new absorb mod
        mob:setLocalVar('currentAbsorb', absorbId)
        mob:setMod(absorbId, 100)

    else
        -- ----------------------------------------------------------------------
        -- when using Light Blade or Great Wheel, can do up to three WS in a row
        -- ----------------------------------------------------------------------

        local wsCount = mob:getLocalVar('wsCount')
        local wsMax = mob:getLocalVar('wsMax')

        if wsCount == 0 then
            wsMax = math.random(0, 2)
            mob:setLocalVar('wsMax', wsMax)
        end

        if wsCount < wsMax then
            mob:setLocalVar('wsCount', wsCount + 1)
            mob:useMobAbility(skillId)
        else
            mob:setLocalVar('wsCount', 0)
        end
    end
end

entity.onMobSpellChoose = function(mob, target)
    local spellList =
    {
        [1] = { xi.magic.spell.DISPELGA,  target, false, xi.action.type.DAMAGE_TARGET,      nil,               0, 100 },
        [2] = { xi.magic.spell.SLOWGA,    target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SLOW,    3, 100 },
        [3] = { xi.magic.spell.SILENCEGA, target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.SILENCE, 0, 100 },
        [4] = { xi.magic.spell.GRAVIGA,   target, false, xi.action.type.ENFEEBLING_TARGET,  xi.effect.WEIGHT,  0, 100 },
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
