-----------------------------------
-- Area: Waughroon Shrine
--  Mob: Titanis Xax
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

entity.onMobMagicPrepare = function(mob, target, spellId)
    local spellTable =
    {
        [1] =
        {
            xi.magic.spell.ADVANCING_MARCH,
            xi.magic.spell.BATTLEFIELD_ELEGY,
        },
        [2] =
        {
            xi.magic.spell.VICTORY_MARCH,
            xi.magic.spell.CARNAGE_ELEGY,
        },
    }
    local spellList = spellTable[mob:getLocalVar('spellList')]
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
