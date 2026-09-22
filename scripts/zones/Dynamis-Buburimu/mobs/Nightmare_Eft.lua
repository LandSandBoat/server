-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Eft
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
        xi.mobSkill.TOXIC_SPIT_2,
        xi.mobSkill.GEIST_WALL_2,
        xi.mobSkill.NUMBING_NOISE_2,
        xi.mobSkill.NIMBLE_SNAP_2,
        xi.mobSkill.CYCLOTAIL_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
