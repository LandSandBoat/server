-----------------------------------
-- Area: Balgas Dais
-- Mob: Nenaunir
-- BCNM: Harem Scarem
-----------------------------------
---@type TMobEntity
local entity = {}

-- Nenaunir does not auto-attack and has 100 TP regain to use Healing Breeze frequently.
entity.onMobInitialize = function(mob)
    mob:setAutoAttackEnabled(false)
    mob:setMod(xi.mod.REGAIN, 100)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 12)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.SILENCE)
end

-- Uses Whistle on engage.
entity.onMobEngage = function(mob, target)
    mob:useMobAbility(xi.mobSkill.WHISTLE)
end

entity.onMobMagicPrepare = function(mob, spell)
    local spellList =
    {
        xi.magic.spell.DIAGA,
        xi.magic.spell.STONE_II,
        xi.magic.spell.BIND
    }
    return spellList[math.random(1, #spellList)]
end

-- Only uses Healing Breeze as a weapon skill.
entity.onMobWeaponSkillPrepare = function(mob, target)
    return xi.mobSkill.HEALING_BREEZE
end

return entity
