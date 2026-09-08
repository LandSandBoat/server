-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Gaylas
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
        xi.mobSkill.SONIC_BOOM_2,
        xi.mobSkill.JET_STREAM_2,
        xi.mobSkill.SLIPSTREAM_2,
        xi.mobSkill.TURBULENCE_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
