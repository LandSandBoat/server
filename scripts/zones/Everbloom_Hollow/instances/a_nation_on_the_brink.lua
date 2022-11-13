-----------------------------------
-- A Nation on the Brink
-- !instance 8600
-----------------------------------
require("scripts/globals/instance")
require("scripts/globals/keyitems")
-----------------------------------
local instance_object = {}

local entities = {}

local aggro = function(instance, id1, id2)
    GetMobByID(id1, instance):addEnmity(GetMobByID(id2, instance), math.random(1, 5), math.random(1, 5))
    GetMobByID(id2, instance):addEnmity(GetMobByID(id1, instance), math.random(1, 5), math.random(1, 5))
end

local slightlyOffsetPath = function(path)
    for i = 1, #path do
        if i % 3 ~= 2 then -- Never the y position
            path[i] = path[i] + math.random(-1.5, 1.5)
        end
    end
    return path
end

local pathToOrcs =
{
    -139.9, 20.0, -141.7,
    -123.7, 20.0, -123.8,
    -108.2, 20.0, -108.2,
     -94.4, 15.7, -102.2,
     -79.9, 11.2, -100.1,
     -62.6, 10.9, -104.5,
     -54.0, 11.0, -139.8,
}

local pathToQuadavs =
{
    -171.4, 18.6, -134.3,
    -163.6, 20.6, -112.9,
    -179.8, 19.0,  -96.4,
    -190.1, 20.0,  -93.9,
}

local pathToYagudos =
{
    -170.1, 20.1, -169.2,
    -190.7, 13.7, -179.8,
    -206.5, 11.2, -182.6,
    -221.5, 10.0, -198.1,
}

instance_object.onInstanceCreated = function(instance)
    local zone = instance:getZone()
    local baseID = zone:queryEntitiesByName("Rongelouts_N_Distaud", instance)[1]:getID()

    entities.Rongelouts  = baseID + 0
    entities.Zazarg      = baseID + 1
    entities.Romaa_Mihgo = baseID + 2

    entities.Iron_Ram_Knight_1 = baseID + 3
    entities.Iron_Ram_Knight_2 = baseID + 4

    entities.Cohors_Legionnaire_1 = baseID + 5
    entities.Cohors_Legionnaire_2 = baseID + 6

    entities.Cobra_Mercenary_1 = baseID + 7
    entities.Cobra_Mercenary_2 = baseID + 8

    entities.Gwajboj = baseID + 9

    entities.Orcish_Gladiator_1 = baseID + 10
    entities.Orcish_Gladiator_2 = baseID + 11
    entities.Orcish_Gladiator_3 = baseID + 12
    entities.Orcish_Gladiator_4 = baseID + 13
    entities.Orcish_Hexspinner_1 = baseID + 14

    entities.Nickel_Quadav_1 = baseID + 15
    entities.Nickel_Quadav_2 = baseID + 16
    entities.Nickel_Quadav_3 = baseID + 17
    entities.Nickel_Quadav_4 = baseID + 18
    entities.Ruby_Quadav_1 = baseID + 19

    entities.Yagudo_Missionary_1 = baseID + 20
    entities.Yagudo_Missionary_2 = baseID + 21
    entities.Yagudo_Missionary_3 = baseID + 22
    entities.Yagudo_Missionary_4 = baseID + 23
    entities.Yagudo_Abbot_1 = baseID + 24

    for _, entityID in pairs(entities) do
        SpawnMob(entityID, instance)

        -- TODO: Do this in the db
        local mob = GetMobByID(entityID, instance)
        mob:setRoamFlags(xi.roamFlag.EVENT)
        mob:setBehaviour(xi.behavior.NO_DESPAWN)
        mob:setMobMod(xi.mobMod.ALWAYS_AGGRO, 1) -- TODO: Allies don't aggro mobs it seems
    end

    -- We'll un-hide the boss once all the adds are dead
    GetMobByID(entities.Gwajboj, instance):setStatus(xi.status.DISAPPEAR)
end

instance_object.onInstanceCreatedCallback = function(player, instance)
    if instance then
        player:setInstance(instance)
        player:setPos(0, 0, 0, 0, instance:getZone():getID())
    end
end

instance_object.afterInstanceRegister = function(player)
end

instance_object.onInstanceTimeUpdate = function(instance, elapsed)
    local elapsedSeconds = elapsed / 1000
    local progress = instance:getProgress()

    print(elapsedSeconds)

    -- After 2 minutes of inactivity, your allies will split off and go fight their beastmen
    if elapsedSeconds >= 120 and progress == 0 then
        instance:setProgress(progress + 1)

        GetMobByID(entities.Rongelouts, instance):pathThrough(slightlyOffsetPath(pathToOrcs))
        GetMobByID(entities.Iron_Ram_Knight_1, instance):pathThrough(slightlyOffsetPath(pathToOrcs))
        GetMobByID(entities.Iron_Ram_Knight_2, instance):pathThrough(slightlyOffsetPath(pathToOrcs))

        GetMobByID(entities.Zazarg, instance):pathThrough(slightlyOffsetPath(pathToQuadavs))
        GetMobByID(entities.Cohors_Legionnaire_1, instance):pathThrough(slightlyOffsetPath(pathToQuadavs))
        GetMobByID(entities.Cohors_Legionnaire_2, instance):pathThrough(slightlyOffsetPath(pathToQuadavs))

        GetMobByID(entities.Romaa_Mihgo, instance):pathThrough(slightlyOffsetPath(pathToYagudos))
        GetMobByID(entities.Cobra_Mercenary_1, instance):pathThrough(slightlyOffsetPath(pathToYagudos))
        GetMobByID(entities.Cobra_Mercenary_2, instance):pathThrough(slightlyOffsetPath(pathToYagudos))

        GetMobByID(entities.Orcish_Gladiator_1, instance):pathThrough(slightlyOffsetPath(pathToOrcs), xi.pathflag.REVERSE)
        GetMobByID(entities.Orcish_Gladiator_2, instance):pathThrough(slightlyOffsetPath(pathToOrcs), xi.pathflag.REVERSE)
        GetMobByID(entities.Orcish_Gladiator_3, instance):pathThrough(slightlyOffsetPath(pathToOrcs), xi.pathflag.REVERSE)
        GetMobByID(entities.Orcish_Gladiator_4, instance):pathThrough(slightlyOffsetPath(pathToOrcs), xi.pathflag.REVERSE)
        GetMobByID(entities.Orcish_Hexspinner_1, instance):pathThrough(slightlyOffsetPath(pathToOrcs), xi.pathflag.REVERSE)

        GetMobByID(entities.Nickel_Quadav_1, instance):pathThrough(slightlyOffsetPath(pathToQuadavs), xi.pathflag.REVERSE)
        GetMobByID(entities.Nickel_Quadav_2, instance):pathThrough(slightlyOffsetPath(pathToQuadavs), xi.pathflag.REVERSE)
        GetMobByID(entities.Nickel_Quadav_3, instance):pathThrough(slightlyOffsetPath(pathToQuadavs), xi.pathflag.REVERSE)
        GetMobByID(entities.Nickel_Quadav_4, instance):pathThrough(slightlyOffsetPath(pathToQuadavs), xi.pathflag.REVERSE)
        GetMobByID(entities.Ruby_Quadav_1, instance):pathThrough(slightlyOffsetPath(pathToQuadavs), xi.pathflag.REVERSE)

        GetMobByID(entities.Yagudo_Missionary_1, instance):pathThrough(slightlyOffsetPath(pathToYagudos), xi.pathflag.REVERSE)
        GetMobByID(entities.Yagudo_Missionary_2, instance):pathThrough(slightlyOffsetPath(pathToYagudos), xi.pathflag.REVERSE)
        GetMobByID(entities.Yagudo_Missionary_3, instance):pathThrough(slightlyOffsetPath(pathToYagudos), xi.pathflag.REVERSE)
        GetMobByID(entities.Yagudo_Missionary_4, instance):pathThrough(slightlyOffsetPath(pathToYagudos), xi.pathflag.REVERSE)
        GetMobByID(entities.Yagudo_Abbot_1, instance):pathThrough(slightlyOffsetPath(pathToYagudos), xi.pathflag.REVERSE)
    end

    -- Force San d'Oria to engage
    if elapsedSeconds >= 40 and progress == 1 then
        local rongelouts = GetMobByID(entities.Rongelouts, instance)
        local gladiator  = GetMobByID(entities.Orcish_Gladiator_1, instance)
        if rongelouts:checkDistance(gladiator) < 15 and not rongelouts:isEngaged() then
            aggro(instance, entities.Rongelouts, entities.Orcish_Gladiator_1)
            aggro(instance, entities.Iron_Ram_Knight_1, entities.Orcish_Gladiator_2)
            aggro(instance, entities.Iron_Ram_Knight_2, entities.Orcish_Gladiator_3)
            aggro(instance, entities.Iron_Ram_Knight_1, entities.Orcish_Gladiator_4)
            aggro(instance, entities.Iron_Ram_Knight_2, entities.Orcish_Hexspinner_1)
        end
    end
end

instance_object.onInstanceFailure = function(instance)
    local chars = instance:getChars()
    for _, v in pairs(chars) do
        v:setPos(-34.2, -16, 58, 32, xi.zone.BATALLIA_DOWNS_S)
    end
end

instance_object.onInstanceProgressUpdate = function(instance, progress)
end

instance_object.onInstanceComplete = function(instance)
end

return instance_object
