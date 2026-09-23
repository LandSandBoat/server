-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Mandragora
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setLocalVar('dynamis_currency', 1452)
    mob:setMobMod(xi.mobMod.NO_H2H_PENALTY, 1)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.HEAD_BUTT_2,
        xi.mobSkill.DREAM_FLOWER_2,
        xi.mobSkill.WILD_OATS_2,
        xi.mobSkill.LEAF_DAGGER_2,
        xi.mobSkill.SCREAM_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
