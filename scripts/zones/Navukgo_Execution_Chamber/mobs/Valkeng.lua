-----------------------------------
-- Area: Navukgo Execution Chamber
--  Mob: Valkeng
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 23)
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 075)
    mob:setMobMod(xi.mobMod.MAGIC_DELAY, 0)
    mob:setMod(xi.mod.DEF, 140)
end

entity.onMobEngage = function(mob, target)
    mob:setMagicCastingEnabled(true) -- Doesn't buff before the fight starts
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    return xi.mobSkill.SLAPSTICK
end

-- These are all the spells caped below 75, however testing suggest that he only chooses 4-6 of these spells depending on the fight. More testing is needed to understand the behavior.
-- Stonega II has been observed at level 75.
entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.BIO,
        xi.magic.spell.BLIND,
        xi.magic.spell.DIA,
        xi.magic.spell.DRAIN,
        xi.magic.spell.DROWN,
        xi.magic.spell.FLASH,
        xi.magic.spell.HASTE,
        xi.magic.spell.PARALYZE,
        xi.magic.spell.REGEN,
        xi.magic.spell.SILENCE,
        xi.magic.spell.SLOW,
        xi.magic.spell.STUN,
        xi.magic.spell.WATER_III,
    }

    return spellList[math.random(1, #spellList)]
end

return entity
