-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Stringes
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.ULTRASONICS_2,
        xi.mobSkill.BLOOD_DRAIN_2,
        xi.mobSkill.SUBSONICS_2,
        xi.mobSkill.MARROW_DRAIN_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
