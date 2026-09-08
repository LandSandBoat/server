-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Snoll
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
        xi.mobSkill.HYPOTHERMAL_COMBUSTION_3,
        xi.mobSkill.FREEZE_RUSH_2,
        xi.mobSkill.COLD_WAVE_3,
        xi.mobSkill.BERSERK_BOMB_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
