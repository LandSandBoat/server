-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Sabotender
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setLocalVar('dynamis_currency', 1452)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.NEEDLESHOT_1,
        xi.mobSkill.TWO_THOUSAND_NEEDLES_1,
        xi.mobSkill.FOUR_THOUSAND_NEEDLES_1,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
