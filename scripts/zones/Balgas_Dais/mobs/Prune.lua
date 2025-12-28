-----------------------------------
-- Area: Balga's Dais
--  Mob: Prune
-- BCNM: Charming Trio
-----------------------------------
---@type TMobEntity
local entity = {}

-- https://docs.google.com/spreadsheets/d/1TnrBzUAQ0hyuFVIjf5OLviIfhGw4vxN1x_4zv9gG4N4/edit?pli=1&gid=368168805#gid=368168805
entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)

    mob:setMobMod(xi.mobMod.MAGIC_COOL, 15)
    mob:setMobMod(xi.mobMod.SOUND_RANGE, 15) -- 15' aggro range
end

entity.onMobSpawn = function(mob)
    mob:setMagicCastingEnabled(false)
end

-- Seems to wait 10ish seconds to cast spells.
-- https://youtu.be/iNzWfVMUxiQ?t=188
-- There is no generic way to do this as far as I know, so set their two spell cast timers to 10~12 seconds
-- TODO: does this only happen on initial engage?
entity.onMobEngage = function(mob, target)
    local delay = (1000 * 10) + math.random(0, 2000)

    mob:timer(delay, function(mobArg)
        mobArg:setMagicCastingEnabled(true)
        mobArg:castSpell()
    end)
end

return entity
