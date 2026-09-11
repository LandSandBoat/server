-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Flytrap
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setLocalVar('dynamis_currency', 1455)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.GLOEOSUCCUS_2,
        xi.mobSkill.SOPORIFIC_2,
        xi.mobSkill.PALSY_POLLEN_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
