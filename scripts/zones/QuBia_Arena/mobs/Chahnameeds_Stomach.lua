-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Chahnameed's Stomach
-- BCNM: An Awful Autopsy
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addMod(xi.mod.REGAIN, 100)
end

entity.onMobMobskillChoose = function(mob, target)
    local skillList =
    {
        xi.mobSkill.INFERNAL_PESTILENCE,
        xi.mobSkill.STINKING_GAS,
        xi.mobSkill.WHIP_TONGUE,
        xi.mobSkill.ABYSS_BLAST,
    }

    return skillList[math.random(1, #skillList)]
end

return entity
