-----------------------------------
-- Area: Castle Zvahl Keep [S]
--  Mob: Titanotaur
-----------------------------------
mixins = { require('scripts/mixins/families/tauri') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobMobskillChoose = function(mob, target)
    local tpMoves =
    {
        xi.mobSkill.TRICLIP_1,
        xi.mobSkill.BACK_SWISH_1,
        xi.mobSkill.MOW_1,
        xi.mobSkill.FRIGHTFUL_ROAR_1,
        xi.mobSkill.UNBLESSED_ARMOR
    }

    if xi.mix.tauri.canUseRay(mob) then
        table.insert(tpMoves, xi.mobSkill.MORTAL_RAY_1)
    end

    return tpMoves[math.random(1, #tpMoves)]
end

return entity
