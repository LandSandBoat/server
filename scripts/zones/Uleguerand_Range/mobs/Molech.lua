-----------------------------------
-- Area: Uleguerand Range
--  Mob: Molech
-- Note: PH for Magnotaur
-----------------------------------
local ID = zones[xi.zone.ULEGUERAND_RANGE]
mixins = { require('scripts/mixins/families/tauri') }
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobWeaponSkillPrepare = function(mob, target)
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

entity.onMobDeath = function(mob, player, optParams)
end

entity.onMobDespawn = function(mob)
    local params = { }
    xi.mob.phOnDespawn(mob, ID.mob.MAGNOTAUR, 10, 3600, params) -- 1 hour
end

return entity
