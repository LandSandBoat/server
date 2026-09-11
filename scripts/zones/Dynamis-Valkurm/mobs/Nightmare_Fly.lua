-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Fly
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
        xi.mobSkill.CURSED_SPHERE_2,
        xi.mobSkill.VENOM_2,
        xi.mobSkill.DEBILITATING_DRONE_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
