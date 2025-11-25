-----------------------------------
-- Area: Behemoth's Dominion
--  HNM: King Behemoth
-----------------------------------
local ID = zones[xi.zone.BEHEMOTHS_DOMINION]
mixins = { require('scripts/mixins/rage') }
-----------------------------------
---@type TMobEntity
local entity = {}

-- Spawn points are for era hnm spawns
entity.spawnPoints =
{
    { x = -267.469, y = -19.831, z =  73.674 },
    { x = -246.354, y = -19.872, z =  51.368 },
    { x = -264.434, y = -19.335, z =  34.277 },
    { x = -283.171, y = -19.108, z =  62.132 },
    { x = -230.417, y = -19.606, z =  54.787 },
    { x = -205.688, y = -19.809, z =  49.544 },
    { x = -265.532, y = -19.931, z =  19.366 },
    { x = -275.173, y = -19.234, z =  62.931 },
    { x = -230.427, y = -19.860, z =  32.231 },
    { x = -241.797, y = -19.006, z =  20.092 },
    { x = -207.049, y = -19.820, z =  44.589 },
    { x = -276.731, y = -20.000, z =  42.023 },
    { x = -236.898, y = -19.014, z =  60.267 },
    { x = -259.411, y = -19.648, z =  67.557 },
    { x = -251.889, y = -20.374, z =  30.462 },
    { x = -223.933, y = -19.498, z =  70.024 },
    { x = -274.929, y = -19.824, z =   7.365 },
    { x = -274.818, y = -19.726, z =  69.297 },
    { x = -241.419, y = -19.047, z =  20.910 },
    { x = -247.958, y = -19.834, z =  12.795 },
    { x = -246.783, y = -19.862, z =  41.047 },
    { x = -266.452, y = -19.581, z =  62.038 },
    { x = -265.990, y = -19.803, z =  71.593 },
    { x = -215.373, y = -19.874, z =  71.096 },
    { x = -280.914, y = -19.454, z =  53.497 },
    { x = -275.127, y = -19.967, z =  76.171 },
    { x = -250.867, y = -19.822, z =  46.063 },
    { x = -271.170, y = -19.481, z =  21.896 },
    { x = -263.103, y = -19.846, z =  61.311 },
    { x = -224.261, y = -20.050, z =  51.632 },
    { x = -234.200, y = -19.122, z =  59.266 },
    { x = -250.542, y = -20.000, z =  71.490 },
    { x = -264.571, y = -19.622, z =  67.562 },
    { x = -226.630, y = -20.130, z =  59.493 },
    { x = -209.427, y = -19.752, z =  44.419 },
    { x = -273.124, y = -19.450, z =  16.986 },
    { x = -234.716, y = -19.537, z =  66.005 },
    { x = -242.586, y = -20.000, z =  36.534 },
    { x = -253.315, y = -19.840, z =  51.327 },
    { x = -207.948, y = -19.892, z =  74.893 },
    { x = -259.626, y = -19.257, z =  71.892 },
    { x = -255.374, y = -19.522, z =  17.760 },
    { x = -228.549, y = -19.629, z =  38.954 },
    { x = -254.377, y = -19.959, z =  55.545 },
    { x = -265.113, y = -19.731, z =  11.899 },
    { x = -212.170, y = -19.653, z =  61.578 },
    { x = -215.301, y = -19.674, z =  50.666 },
    { x = -272.468, y = -19.879, z =  30.012 },
    { x = -223.880, y = -19.195, z =  36.637 },
    { x = -233.462, y = -19.692, z =  66.303 }
}

entity.onMobInitialize = function(mob)
    mob:addImmunity(xi.immunity.STUN)
    mob:addImmunity(xi.immunity.SILENCE)
    mob:addImmunity(xi.immunity.LIGHT_SLEEP)
    mob:addImmunity(xi.immunity.DARK_SLEEP)
    mob:addImmunity(xi.immunity.PETRIFY)

    mob:setMobMod(xi.mobMod.ADD_EFFECT, 1)
    mob:setMobMod(xi.mobMod.MAGIC_COOL, 60)
end

entity.onMobSpawn = function(mob)
    mob:setLocalVar('[rage]timer', 3600) -- 60 minutes
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
    mob:setMobMod(xi.mobMod.WEAPON_BONUS, 58) -- 145 total weapaon damage
    mob:setMod(xi.mod.MDEF, 20)
    mob:setMod(xi.mod.ATT, 462)
    mob:setMod(xi.mod.DEF, 500)
    mob:setMod(xi.mod.EVA, 370)
    mob:setMod(xi.mod.TRIPLE_ATTACK, 5)

    -- Despawn the ???
    GetNPCByID(ID.npc.BEHEMOTH_QM):setStatus(xi.status.DISAPPEAR)
end

entity.onMobRoam = function(mob)
    mob:setMobMod(xi.mobMod.NO_MOVE, 0)
end

entity.onMobFight = function(mob, target)
    local drawInTable =
    {
        conditions =
        {
            target:getXPos() > -180 and target:getZPos() > 53,
            target:getXPos() > -230 and target:getZPos() < 5,
        },
        position = mob:getPos(),
        wait = 3,
    }
    for _, condition in ipairs(drawInTable.conditions) do
        if condition then
            mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            utils.drawIn(target, drawInTable)
            break
        else
            mob:setMobMod(xi.mobMod.NO_MOVE, 0)
        end
    end

    local delay = mob:getLocalVar('delay')
    if
        GetSystemTime() > delay and
        mob:canUseAbilities()
    then -- Use Meteor every 40s, based on capture
        mob:castSpell(xi.magic.spell.METEOR, target)
        mob:setLocalVar('delay', GetSystemTime() + 40)
    end
end

entity.onAdditionalEffect = function(mob, target, damage)
    return xi.mob.onAddEffect(mob, target, damage, xi.mob.ae.STUN, { chance = 20, duration = math.random(4, 8) })
end

entity.onSpellPrecast = function(mob, spell)
    if spell:getID() == xi.magic.spell.METEOR then
        spell:setAoE(xi.magic.aoe.RADIAL)
        spell:setFlag(xi.magic.spellFlag.HIT_ALL)
        spell:setRadius(25)
        spell:setAnimation(280)
        spell:setMPCost(0)
    end
end

entity.onMobDeath = function(mob, player, optParams)
    player:addTitle(xi.title.BEHEMOTH_DETHRONER)
end

entity.onMobDespawn = function(mob)
    -- Respawn the ???
    GetNPCByID(ID.npc.BEHEMOTH_QM):updateNPCHideTime(xi.settings.main.FORCE_SPAWN_QM_RESET_TIME)
end

return entity
