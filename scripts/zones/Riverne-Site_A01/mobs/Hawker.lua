-----------------------------------
-- Area: Riverne - Site A01
--  Mob: Hawker
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target, skillId)
    local tpTable =
    {
        xi.mobSkill.CURSED_SPHERE_1,
        xi.mobSkill.VENOM_1,
        xi.mobSkill.SOMERSAULT_1,
    }

    return tpTable[math.randomInt(1, #tpTable)]
end

return entity
