-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Weapon
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
        xi.mobSkill.SMITE_OF_FURY_2,
        xi.mobSkill.SMITE_OF_RAGE_2,
        xi.mobSkill.WHIRL_OF_RAGE_2,
        xi.mobSkill.FLURRY_OF_RAGE_2,
        xi.mobSkill.WHISPERS_OF_IRE_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
