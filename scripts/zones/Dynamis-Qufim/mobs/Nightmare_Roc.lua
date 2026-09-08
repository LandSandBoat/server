-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Nightmare Roc
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
        xi.mobSkill.BLIND_VORTEX_2,
        xi.mobSkill.GIGA_SCREAM_2,
        xi.mobSkill.DREAD_DIVE_2,
        xi.mobSkill.FEATHER_BARRIER_2,
        xi.mobSkill.STORMWIND_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
