-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Titanis Jax
-- KSNM: Prehistoric Pigeons
-----------------------------------
mixins = { require('scripts/mixins/job_special') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 20)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('spellList', 1)
    mob:setMod(xi.mod.REGAIN, 200)
    xi.mix.jobSpecial.config(mob, {
        specials =
        {
            { id = xi.jsa.SOUL_VOICE, hpp = 60 },
        },
    })
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellTable =
    {
        [1] =
        {
            xi.magic.spell.ARMYS_PAEON_IV,
            xi.magic.spell.DARK_CAROL,
            xi.magic.spell.EARTH_CAROL,
            xi.magic.spell.FIRE_CAROL,
            xi.magic.spell.ICE_CAROL,
            xi.magic.spell.LIGHT_CAROL,
            xi.magic.spell.LIGHTNING_CAROL,
            xi.magic.spell.WATER_CAROL,
            xi.magic.spell.WIND_CAROL,
        },
        [2] =
        {
            xi.magic.spell.ARMYS_PAEON_V,
            xi.magic.spell.DARK_CAROL,
            xi.magic.spell.EARTH_CAROL,
            xi.magic.spell.FIRE_CAROL,
            xi.magic.spell.ICE_CAROL,
            xi.magic.spell.LIGHT_CAROL,
            xi.magic.spell.LIGHTNING_CAROL,
            xi.magic.spell.WATER_CAROL,
            xi.magic.spell.WIND_CAROL,
        },
    }

    local list      = mob:getLocalVar('spellList')
    list            = list > 0 and list or 1
    local spellList = spellTable[list]

    return spellList[math.random(1, #spellList)]
end

entity.onMobFight = function(mob, target)
    local battlefield = mob:getBattlefield()
    if battlefield then
        local deathCount = battlefield:getLocalVar('pigeonDeaths')
        if deathCount > 0 then
            local hasteValue = 750 * deathCount
            mob:setMod(xi.mod.HASTE_ABILITY, hasteValue)
            mob:setMod(xi.mod.HASTE_GEAR, hasteValue)
            mob:setMod(xi.mod.HASTE_MAGIC, hasteValue)
        end
    end
end

entity.onMobWeaponSkill = function(target, mob, skill)
    if skill:getID() == xi.mobSkill.SOUL_VOICE_1 then -- 696
        mob:setLocalVar('spellList', 2)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    if optParams.isKiller or optParams.noKiller then
        local battlefield = mob:getBattlefield()
        if battlefield then
            local deathCount = battlefield:getLocalVar('pigeonDeaths')
            battlefield:setLocalVar('pigeonDeaths', deathCount + 1)
        end
    end
end

return entity
