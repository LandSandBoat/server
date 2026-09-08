-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Raptor
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
        xi.mobSkill.RIPPER_FANG_2,
        xi.mobSkill.FOUL_BREATH_2,
        xi.mobSkill.FROST_BREATH_2,
        xi.mobSkill.THUNDERBOLT_2,
        xi.mobSkill.CHOMP_RUSH_2,
        xi.mobSkill.SCYTHE_TAIL_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
