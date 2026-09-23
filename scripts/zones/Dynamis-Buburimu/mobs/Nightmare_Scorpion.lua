-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Scorpion
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setLocalVar('dynamis_currency', 1449)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.CRITICAL_BITE,
        xi.mobSkill.VENOM_STING_1,
        xi.mobSkill.STASIS,
        xi.mobSkill.VENOM_STORM_1,
        xi.mobSkill.EARTHBREAKER_1,
        xi.mobSkill.EVASION,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
