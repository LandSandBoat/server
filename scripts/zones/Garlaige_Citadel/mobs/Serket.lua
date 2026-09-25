-----------------------------------
-- Area: Garlaige Citadel (200)
--   NM: Serket
-----------------------------------
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400))

    mob:setMobMod(xi.mobMod.GIL_MIN, 20000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 20000)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.POISON)
end

entity.onMobSpawn = function(mob)
    mob:setMod(xi.mod.REGEN, 10)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setLocalVar('[rage]timer', 1800) -- 30 minutes
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) > mob:getMeleeRange(target),
        },
        position = mob:getPos(),
        wait = 3,
    }
    utils.drawIn(target, drawInTable)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.VENOM_STING_1,
        xi.mobSkill.VENOM_STORM_1,
        xi.mobSkill.VENOM_BREATH_1,
        xi.mobSkill.CRITICAL_BITE,
        xi.mobSkill.EARTHBREAKER_1,
        xi.mobSkill.STASIS,
        xi.mobSkill.EVASION,
    }

    return skillList[math.randomInt(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    return xi.magic.spell.BINDGA
end

entity.onMobDeath = function(mob, player, optParams)
    if player then
        player:addTitle(xi.title.SERKET_BREAKER)
    end
end

entity.onMobDespawn = function(mob)
    mob:setRespawnTime(math.randomInt(75600, 86400)) -- 21 to 24 hours
end

return entity
