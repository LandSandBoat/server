-----------------------------------
-- Area: Mine Shaft 2716
-- Mob: Fantoccini Automaton
-- ENM: Pulling the Strings
-----------------------------------
local ID = require("scripts/zones/Mine_Shaft_2716/IDs")
-----------------------------------
local entity = {}

entity.onMobSpawn = function(mob)
    -- Mob is untargetable without this. TODO: Figure out why
    mob:setUntargetable(false)
end

entity.onMobFight = function(mob, target)
    local fantoccini = GetMobByID(ID.mob.FANTOCCINI[mob:getBattlefield():getArea()])

    -- Ice Maneuver (Magic automaton casts spells)
    if fantoccini:getLocalVar("petModel") == 3 and mob:hasStatusEffect(xi.effect.ICE_MANEUVER) then
        mob:setMobMod(xi.mobMod.SPELL_LIST, ID.jobTable[xi.job.PUP].petSpellList[mob:getLocalVar("petModel")])
    else
        mob:setMobMod(xi.mobMod.SPELL_LIST, 0)
    end

    -- Thunder Maneuver (Ranged automaton uses weapon skills)
    if fantoccini:getLocalVar("petModel") == 2 and mob:hasStatusEffect(xi.effect.ICE_MANEUVER) then
        mob:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[xi.job.PUP].petSkillList[mob:getLocalVar("petModel")])
    else
        mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    end

    -- Fire Maneuver (Ranged and Magic automatons use weapon skills)
    if fantoccini:getLocalVar("petModel") ~= 2 and mob:hasStatusEffect(xi.effect.FIRE_MANEUVER) then
        mob:setMobMod(xi.mobMod.SKILL_LIST, ID.jobTable[xi.job.PUP].petSkillList[mob:getLocalVar("petModel")])
    else
        mob:setMobMod(xi.mobMod.SKILL_LIST, 0)
    end
end

entity.onMobDeath = function(mob, player, isKiller)
end

return entity
