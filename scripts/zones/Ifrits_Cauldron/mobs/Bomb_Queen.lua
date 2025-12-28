-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Bomb Queen
--  Vid: https://www.youtube.com/watch?v=AVsEbYjSAHM
-----------------------------------
mixins = { require('scripts/mixins/draw_in') }
-----------------------------------
---@type TMobEntity
local entity = {}

local ID = zones[xi.zone.IFRITS_CAULDRON]

local basicPets =
{
    ID.mob.BOMB_QUEEN + 1,
    ID.mob.BOMB_QUEEN + 2,
    ID.mob.BOMB_QUEEN + 3,
    ID.mob.BOMB_QUEEN + 4,
}

local bombBastard = ID.mob.BOMB_QUEEN + 5

local callPetParams =
{
    inactiveTime = 5000,
    dieWithOwner = true,
    maxSpawns = 1,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.HP_STANDBACK, -1)
    mob:setMobMod(xi.mobMod.GIL_MIN, 15000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 3370)
    mob:setMod(xi.mod.STUN_MEVA, 50)
end

entity.onMobSpawn = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:setLocalVar('spawn_time', GetSystemTime() + 5) -- five seconds for first pet
end

entity.onMobFight = function(mob, target)
    -- Every 30 seconds spawn a random Prince or Princess. If none remain then summon the Bastard.
    -- Retail confirmed
    if
        not xi.combat.behavior.isEntityBusy(mob) and
        GetSystemTime() >= mob:getLocalVar('spawn_time')
    then
        mob:setLocalVar('spawn_time', GetSystemTime() + 30)

        -- will call the first that is not spawned
        if not xi.mob.callPets(mob, utils.shuffle(basicPets), callPetParams) then
            xi.mob.callPets(mob, bombBastard, callPetParams)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
