-----------------------------------
-- Tauri NM Mixin
-- Checks if Taurus has used Mortal Ray already and prevents multiple uses
--
-- Usage in mob files:
-- 1. Add mixin: mixins = { require('scripts/mixins/families/tauri') }
--
-- For custom skill selection, you can also manually call:
--   if xi.mix.tauri.canUseRay(mob) then
--     table.insert(tpMoves, xi.mobSkill.MORTAL_RAY_1)
--   end
-----------------------------------
require('scripts/globals/mixins')
xi = xi or {}
xi.mix = xi.mix or {}
xi.mix.tauri = xi.mix.tauri or {}

g_mixins = g_mixins or {}
g_mixins.families = g_mixins.families or {}

xi.mix.tauri.canUseRay = function(mob)
    -- Normal Tauri only use mortal ray once per life
    if mob:getLocalVar('mortalRayUsed') == 1 then
        return false
    end

    return true
end

g_mixins.families.tauri = function(tauriMob)
    tauriMob:addListener('WEAPONSKILL_USE', 'TAURI_NM_WEAPONSKILL_USE', function(mob, target, skillid, tp, action)
        if skillid == xi.mobSkill.MORTAL_RAY_1 then
            mob:setLocalVar('mortalRayUsed', 1)
        end
    end)
end

return g_mixins.families.tauri
