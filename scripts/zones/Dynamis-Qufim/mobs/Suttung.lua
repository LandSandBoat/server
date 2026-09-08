-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Suttung
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.CRYSTAL_SHIELD_2,
        xi.mobSkill.HEAVY_STRIKE_2,
        xi.mobSkill.ICE_BREAK_2,
        xi.mobSkill.THUNDER_BREAK_2,
        xi.mobSkill.CRYSTAL_RAIN_2,
        xi.mobSkill.CRYSTAL_WEAPON_FIRE_2,
        xi.mobSkill.CRYSTAL_WEAPON_STONE_2,
        xi.mobSkill.CRYSTAL_WEAPON_WATER_2,
        xi.mobSkill.CRYSTAL_WEAPON_WIND_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
