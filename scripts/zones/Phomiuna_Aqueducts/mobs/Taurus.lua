-----------------------------------
-- Area: Phomiuna Aqueducts
--  Mob: Taurus
-----------------------------------
mixins = { require('scripts/mixins/families/tauri') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobWeaponSkillPrepare = function(mob, target)
    local tpMoves =
    {
        xi.mobSkills.TRICLIP_1,
        xi.mobSkills.BACK_SWISH_1,
        xi.mobSkills.MOW_1,
        xi.mobSkills.FRIGHTFUL_ROAR_1,
        xi.mobSkills.UNBLESSED_ARMOR
    }

    if xi.mix.tauri.canUseRay(mob) then
        table.insert(tpMoves, xi.mobSkills.MORTAL_RAY_1)
    end

    return tpMoves[math.random(1, #tpMoves)]
end

return entity
