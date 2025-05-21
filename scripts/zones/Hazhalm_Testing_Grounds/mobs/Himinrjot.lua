-----------------------------------
-- Area: Hazhalm Testing Grounds
--   NM: Himinrjot (Einherjar)
-- Notes: Uses Snort as its auto-attacks
-- Unverified/unimplemented:
--  - High defense, stronger in the front
-----------------------------------
mixins =
{
    require('scripts/mixins/draw_in'),
}
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobInitialize = function(mob)
    xi.einherjar.onBossInitialize(mob)
    mob:addImmunity(xi.immunity.BIND)
    mob:addImmunity(xi.immunity.GRAVITY)

    mob:setMobSkillAttack(2043) -- himinrjot_aa skill list
end

entity.onMobSpawn = function(mob)
    -- Snort about every 5 seconds
    mob:setDelay(2000)
end

return entity
