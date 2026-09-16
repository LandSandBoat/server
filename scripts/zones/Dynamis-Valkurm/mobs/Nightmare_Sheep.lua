-----------------------------------
-- Area: Dynamis - Valkurm
--  Mob: Nightmare Sheep
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
        xi.mobSkill.LAMB_CHOP_1,
        xi.mobSkill.SHEEP_BLEAT_2,
        xi.mobSkill.SHEEP_SONG_2,
        xi.mobSkill.SHEEP_CHARGE_3,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
