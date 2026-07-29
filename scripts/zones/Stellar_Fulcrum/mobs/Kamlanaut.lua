-----------------------------------
-- Area: Stellar Fulcrum
--  Mob: Kam'lanaut
-- Zilart Mission 8 BCNM Fight
-----------------------------------
---@type TMobEntity
local entity = {}

local skillToAbsorb =
{
    [823] = xi.mod.FIRE_ABSORB,  -- fire_blade
    [824] = xi.mod.ICE_ABSORB,   -- frost_blade
    [825] = xi.mod.WIND_ABSORB,  -- wind_blade2
    [826] = xi.mod.EARTH_ABSORB, -- earth_blade
    [827] = xi.mod.LTNG_ABSORB,  -- lightning_blade
    [828] = xi.mod.WATER_ABSORB, -- water_blade
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)
    mob:addImmunity(xi.immunity.TERROR)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 15)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMobMod(xi.mobMod.DETECTION, xi.detects.HEARING)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15)
end

entity.onMobEngage = function(mob, target)
    mob:setLocalVar('nextEnSkill', GetSystemTime() + 10)
end

entity.onMobFight = function(mob, target)
    if GetSystemTime() > mob:getLocalVar('nextEnSkill') then
        local skill = math.randomInt(823, 828)
        mob:setLocalVar('currentTP', mob:getTP())
        mob:useMobAbility(skill)
        mob:setLocalVar('nextEnSkill', GetSystemTime() + math.randomInt(25, 30))
    end
end

entity.onMobWeaponSkill = function(mob, target, skill, action)
    local skillId  = skill:getID()
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

        -- return TP
        mob:setTP(mob:getLocalVar('currentTP'))
    end
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        [1] = { xi.magic.spell.SLOWGA,    target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SLOW,    3, 100 },
        [2] = { xi.magic.spell.SILENCEGA, target, false, xi.action.type.ENFEEBLING_TARGET, xi.effect.SILENCE, 0, 100 },
        [3] = { xi.magic.spell.DISPELGA,  target, false, xi.action.type.NONE,              nil,               0, 100 }, -- He always uses dispel, even if the player isn't buffed.
    }

    return xi.combat.behavior.chooseAction(mob, target, nil, spellList)
end

return entity
