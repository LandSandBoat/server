-----------------------------------
-- Area: Ifrit's Cauldron
--   NM: Bomb Queen
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
    ignoreInactive = true,
    maxSpawns = 1,
}

entity.onMobInitialize = function(mob)
    mob:setMobMod(xi.mobMod.IDLE_DESPAWN, 900)
    mob:setMobMod(xi.mobMod.NO_MOVE, 1)

    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.TERROR)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.GIL_MIN, 18000)
    mob:setMobMod(xi.mobMod.GIL_MAX, 18000)
    mob:setMobMod(xi.mobMod.MUG_GIL, 3370)
end

entity.onMobSpawn = function(mob)
    mob:setMobMod(xi.mobMod.BASE_DAMAGE_MULTIPLIER, 150)
    mob:setMod(xi.mod.REGEN, 25)
    mob:setLocalVar('spawn_time', GetSystemTime() + 5) -- five seconds for first pet
end

entity.onMobFight = function(mob, target)
    -- Every 17-30 seconds unless extended by a spell cast spawn a random Prince or Princess. If none remain then summon the Bastard.
    local drawInTable =
    {
        conditions =
        {
            mob:checkDistance(target) >= mob:getMeleeRange(target),
        },

        position = { x = 020.918, y = 019.953, z = -108.722, rot = 058.000 },
    }

    utils.drawIn(target, drawInTable)
    if
        not xi.combat.behavior.isEntityBusy(mob) and
        GetSystemTime() >= mob:getLocalVar('spawn_time')
    then
        mob:setLocalVar('spawn_time', GetSystemTime() + math.random(17, 30))
        mob:setMagicCastingEnabled(false)

        -- will call the first that is not spawned
        if not xi.mob.callPets(mob, utils.shuffle(basicPets), callPetParams) then
            xi.mob.callPets(mob, bombBastard, callPetParams)
        end
    end
end

entity.onMobDeath = function(mob, player, optParams)
end

return entity
