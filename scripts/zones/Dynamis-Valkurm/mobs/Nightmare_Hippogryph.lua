-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Hippogryph
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
        xi.mobSkill.NIHILITY_SONG_1,
        xi.mobSkill.JETTATURA_1,
        xi.mobSkill.HOOF_VOLLEY,
        xi.mobSkill.CHOKE_BREATH_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
