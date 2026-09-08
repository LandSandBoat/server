-----------------------------------
-- Area: Dynamis - Qufim
--  Mob: Scolopendra
-----------------------------------
mixins = { require('scripts/mixins/dynamis_dreamland') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    xi.dynamis.mobInfo(mob)
    mob:setMod(xi.mod.DOUBLE_ATTACK, 95)
end

entity.onMobMobskillChoose = function(mob, target, skillId)
    local skillList =
    {
        xi.mobSkill.TENTACLE_2,
        xi.mobSkill.INK_JET_2,
        xi.mobSkill.HARD_MEMBRANE_2,
        xi.mobSkill.CROSS_ATTACK_2,
        xi.mobSkill.REGENERATION_2,
        xi.mobSkill.MAELSTROM_2,
        xi.mobSkill.WHIRLWIND_2,
    }

    return skillList[math.randomInt(1, #skillList)]
end

return entity
