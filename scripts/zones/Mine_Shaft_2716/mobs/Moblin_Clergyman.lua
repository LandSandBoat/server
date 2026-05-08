-----------------------------------
-- Area: Mine Shaft 2716
-- Return to the Depths: Bastok Quest: 1 79
-- NM: Twilotak
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.GRAVITY)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PLAGUE)
    mob:addImmunity(xi.immunity.SILENCE)

    mob:addListener('MAGIC_STATE_EXIT', 'MAGIC_EMOTE', function(mobArg, spell)
        mobArg:useMobAbility(xi.mobSkill.MOBLIN_EMOTE_3)
    end)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 240)
    mob:setAutoAttackEnabled(false)
    mob:setMagicCastingEnabled(false)
    mob:setMobAbilityEnabled(false)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)
end

entity.onMobEngage = function(mob, target)
    mob:setMagicCastingEnabled(true)
end

-- TODO: Change casting logic to only target Twilotak and random players
entity.onMobSpellChoose = function(mob, target, spell)
    local spellList =
    {
        xi.magic.spell.CURE_IV,
        xi.magic.spell.HOLY,
        xi.magic.spell.PROTECT_III,
    }

    return spellList[math.random(1, #spellList)]
end

return entity
