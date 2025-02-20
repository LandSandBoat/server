-----------------------------------
-- Area: The Shrine of Ru'Avitau
--  Mob: Seiryu (Pet version)
-----------------------------------
---@type TMobEntity
local entity = {}

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.CANNOT_GUARD, 1)
end

entity.onMobMagicPrepare = function(mob, target, spellId)
    if not mob:hasStatusEffect(xi.effect.HUNDRED_FISTS, 0) then
        local rnd = math.random(1, 100)
        if rnd <= 50 then
            return 186 -- aeroga 3
        elseif rnd <= 70 then
            return 157 -- aero 4
        elseif rnd <= 90 then
            return 208 -- tornado
        else
            return 237 -- choke
        end
    end

    return 0 -- Still need a return, so use 0 when not casting
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
