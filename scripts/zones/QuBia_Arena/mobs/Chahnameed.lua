-----------------------------------
-- Area: Qu'Bia Arena
--  Mob: Chahnameed
-- BCNM: An Awful Autopsy
-- Note: This mob is an enrage mechanic and isn't meant to be defeated.
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addMod(xi.mod.REGAIN, 300)
    mob:addMod(xi.mod.UDMGPHYS, 9000)
    mob:setMod(xi.mod.UDMGMAGIC, 9000)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 200)
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
