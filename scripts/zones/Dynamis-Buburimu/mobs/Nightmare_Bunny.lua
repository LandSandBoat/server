-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Bunny
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
        xi.mobSkill.FOOT_KICK_2,
        xi.mobSkill.DUST_CLOUD_2,
        xi.mobSkill.WHIRL_CLAWS_2,
        xi.mobSkill.WILD_CARROT_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
