-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Fantoccini Automaton
-- ENM: Pulling the Strings
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
end

entity.onMobFight = function(mob, target)
    local fantoccini = GetMobByID(ID.mob.FANTOCCINI[mob:getBattlefield():getArea()])
    local model = mob:getLocalVar("petModel")

    -- Ice Maneuver (Magic automaton casts spells)
    if
        fantoccini:getLocalVar("petModel") == 3 and
        mob:hasStatusEffect(xi.effect.ICE_MANEUVER)
    then
        mob:setMobMod(xi.mobMod.SPELL_LIST, ID.jobTable[xi.job.PUP].petSpellList[model])
        mob:setMagicCastingEnabled(true)
    else
        mob:setMagicCastingEnabled(false)
    end

    -- Thunder Maneuver (Ranged automaton uses weapon skills)
    if
        fantoccini:getLocalVar("petModel") == 2 and
        mob:hasStatusEffect(xi.effect.ICE_MANEUVER)
    then
        mob:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[xi.job.PUP].petSkillList[model])
    else
        mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    end

    -- Fire Maneuver (Ranged and Magic automatons use weapon skills)
    if
        fantoccini:getLocalVar("petModel") ~= 2 and
        mob:hasStatusEffect(xi.effect.FIRE_MANEUVER)
    then
        mob:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[xi.job.PUP].petSkillList[model])
    else
        mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
