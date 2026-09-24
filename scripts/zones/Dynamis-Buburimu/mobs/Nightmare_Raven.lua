-----------------------------------
-- Area: Dynamis - Buburimu
--  Mob: Nightmare Raven
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
        xi.mobSkill.HELLDIVE_2,
        xi.mobSkill.WING_CUTTER_2,
        xi.mobSkill.BROADSIDE_BARRAGE_2,
        xi.mobSkill.BLIND_SIDE_BARRAGE_2,
        xi.mobSkill.DAMNATION_DIVE_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
