-----------------------------------
-- Area: Horlais Peak
--  Mob: Huntfly
-- BCNM: Dropping Like Flies
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:setMobMod(xi.mobMod.NO_STANDBACK, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
end

entity.onMobMobskillChoose = function(mob, target)
    local skillList =
    {
        xi.mobSkill.CURSED_SPHERE_1,
        xi.mobSkill.SOMERSAULT_1,
    }

    return skillList[math.random(1, #skillList)]
end

entity.onMobSpellChoose = function(mob, target, spellId)
    local spellList =
    {
        xi.magic.spell.AERO,
    }

    if not target:hasStatusEffect(xi.effect.CHOKE) then
        table.insert(spellList, xi.magic.spell.CHOKE)
    end

    if not target:hasStatusEffect(xi.effect.WEIGHT) then
        table.insert(spellList, xi.magic.spell.GRAVITY)
    end

    return spellList[math.random(1, #spellList)]
end

return entity
