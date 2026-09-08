-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Tiger
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
        xi.mobSkill.ROAR_2,
        xi.mobSkill.RAZOR_FANG_2,
        xi.mobSkill.CLAW_CYCLONE_2,
        xi.mobSkill.PREDATORY_GLARE_2,
        xi.mobSkill.CROSSTHRASH_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
