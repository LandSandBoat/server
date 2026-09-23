-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Crawler
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
        xi.mobSkill.STICKY_THREAD_2,
        xi.mobSkill.POISON_BREATH_2,
        xi.mobSkill.COCOON_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
