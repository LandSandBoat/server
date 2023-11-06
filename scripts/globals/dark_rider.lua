----------------------------------------------------------------------------------------------------------
-- Hoofprint + Dark Rider Behaviour
--
-- Era Behaviour Notes:
-- According to testimonies online:
-- Dark Rider was only ever witnessed before Einherjar's release.
-- Instant casts death when engaged.
-- Was unkillable. (However players reported witnessing 99% HP which indicates not undamageable)
-- Dark Rider's minions appear to spawn in random locations along his current path.
-- When Dark Rider despawns, the hoofprint will appear somewhere in the path that he took.
--
-- Retail Behaviour Notes:
-- Continued limited information exists about the behavior of the Warhorse Footprint.
-- Until further evidence presents itself, the hoofprint will be set to spawn in reported
-- locations every 8 - 24 hours; allowing for multiple hoofprints to be available at any given moment.
-- Logic deducing a minimum of 8 hours stems from there being 3 IDs for the hoofprint in each zone.
-- Whereas a respawn time of 8 hours allows for a possible total of 3 hoofprints to be available before midnight.
----------------------------------------------------------------------------------------------------------
xi = xi or {}
xi.dark_rider = xi.dark_rider or {}

-- WARNING: Changing these globals can cause issues and bugs.
-- Please ensure you understand what they do before adjusting.
local eraRespawnTime  = math.random(115200, 129600) -- 32 - 36 Hours
local respawnTime      = math.random(28800, 86400) -- 8 - 24 Hours
local hoofprintDespawn = getMidnight() -- Server Midnight

local darkRider =
{
    16990423, -- Bhaflau Thickets
    17101136, -- Caedarve Mire
    17027459, -- Mount Zhayolm
    16986421, -- Wajaom Woodlands
}

local eraHoofprintTable =
{
    16990593, -- Bhaflau Thickets
    17101292, -- Caedarva Mire
    17027511, -- Mount Zhayolm
    16986601, -- Wajaom Woodlands
}

local hoofprintTable =
{
    [1] =  -- Wajaom Woodlands
    {
        16986601,
        16986602,
        16986603,
    },

    [2] = -- Bhaflau Thickets
    {
        16990593,
        16990594,
        16990595,
    },

    [3] = -- Caedarva Mire
    {
        17101292,
        17101293,
        17101294,
    },

    [4] = -- Mount Zhayolm
    {
        17027511,
        17027512,
        17027513,
    },
}

-- Reported retail hoofprint sightings
local hoofprintSpawnTable =
{
    [1] = -- Wajaom Woodlands
    {
        { x = -424.9057, y = -26,      z = 402.1342,  },
        { x = -403.6593, y = -26.675,  z = 420.17,    },
        { x = -340.7972, y = -25.3687, z = 418.9442,  },
        { x = -337.9268, y = -25.2,    z = 379.6009,  },
        { x = -100.5313, y = -25.2905, z = 380.6889,  },
        { x = -97.6254,  y = -25.5081, z = 422.2883,  },
        { x = -21.3175,  y = -25.5201, z = 417.9361,  },
        { x = -18.597,   y = -25.2,    z = 379.9245,  },
        { x = 18.9188,   y = -25.4514, z = 378.3926,  },
        { x = 22.1008,   y = -25.3901, z = 341.1984,  },
        { x = 260.4213,  y = -25.5059, z = 298.3005,  },
        { x = 262.7604,  y = -25.2499, z = 260.2626,  },
        { x = 377.5822,  y = -17.5058, z = 138.0416,  },
        { x = 240.66,    y = -16.9543, z = 89.0583,   },
        { x = 340.4471,  y = -17.5018, z = 57.9434,   },
        { x = 225.1382,  y = -18.1488, z = -63.1682,  },
        { x = 182.6348,  y = -17.5,    z = -140.1927, },
        { x = 81.7582,   y = -18.675,  z = -258.8897, },
        { x = -40.4687,  y = -16,      z = -323.4648, },
        { x = -98.5469,  y = -17.4289, z = -461.1623, },
        { x = -111.7744, y = -20.2552, z = -570.4197, },
        { x = -183.2211, y = -18,      z = -420.4932, },
    },

    [2] = -- Bhaflau Thickets
    {
        { x = -355.7132, y = -7.957,   z = -100.719,  },
        { x = -382.3345, y = -11.7201, z = -99.5111,  },
        { x = -447.8948, y = -15.902,  z = -99.4241,  },
        { x = -472.5616, y = -22.2612, z = -98.0313,  },
        { x = -469.0232, y = -22,      z = -62.6762,  },
        { x = -465.3344, y = -24.1546, z = -44.8208,  },
        { x = -483.9292, y = -22,      z = -66.44,    },
        { x = -485.6291, y = -19.8621, z = -84.8009,  },
        { x = -499.7253, y = -15.5648, z = -82.5116,  },
        { x = -516.3804, y = -11.75,   z = -71.4453,  },
        { x = -550.2809, y = -11.75,   z = -38.7637,  },
        { x = -557.1318, y = -11.6048, z = -54.3491,  },
        { x = -556.5707, y = -12,      z = -80.6662,  },
        { x = -558.8506, y = -16.1294, z = -103.2708, },
        { x = -574.0215, y = -11.1222, z = -68.5697   },
        { x = -577.002,  y = -8.132,   z = -46.9655,  },
        { x = -623.8424, y = -7.9782,  z = -45.4641,  },
        { x = -602.5402, y = -3.75,    z = -29.6118,  },
        { x = -597.8671, y = -3.75,    z = -8.6846,   },
        { x = -583.291,  y = -5.8732,  z = 14.1616,   },
        { x = -574.1631, y = -8.25,    z = 34.108,    },
        { x = -572.1212, y = -6.2157,  z = 55.2067,   },
        { x = -572.8939, y = -8.3158,  z = 24.2096,   },
        { x = -573.9182, y = -8.3817,  z = -10.5209,  },
        { x = -574.8887, y = -8.25,    z = -37.9213,  },
    },

    [3] = -- Caedarva Mire
    {
        { x = -596.229, y = 4.000,   z = -117.535 },
        { x = 161.434,  y = -8.000,  z = -357.040 },
        { x = 285.521,  y = -15.906, z = -360.479 },
        { x = 372.167,  y = -18.830, z = -375.590 },
        { x = 395.638,  y = -9.479,  z = -186.463 },
        { x = 457.039,  y = -7.000,  z = -274.326 },
        { x = 253.783,  y = -2.000,  z = -534.556 },
    },

    [4] = -- Mount Zhayolm
    {
        { x = -434.779, y = -13.940, z = 360.158  },
        { x = -482.238, y = -13.831, z = 327.390  },
        { x = -332.465, y = -14.059, z = 300.180  },
        { x = 185.049,  y = -13.713, z = -214.977 },
        { x = 277.437,  y = -17.999, z = -293.978 },
        { x = 600.765,  y = -17.019, z = 7.817    },
        { x = 746.707,  y = -13.588, z = -55.732  },
    },
}

xi.dark_rider.isDarkRiderEnabled = function()
    return xi.settings.main.ENABLE_DARK_RIDER
end

-- This function is called from Aht_Urhgan_Whitegate/Zone.lua and is called onGameHour
-- Hoofprint spawning will be controlled by either Dark Rider or a simple timer
xi.dark_rider.init = function()
    if xi.dark_rider.isDarkRiderEnabled() then
        local chosenRider = math.random(1, #darkRider)

        if
            GetServerVariable("[DARKRIDER]respawnTime") < os.time() and
            GetServerVariable("[DARKRIDER]isSpawned") == 0 and
            (VanadielTOTD() == xi.time.NIGHT or VanadielTOTD() == xi.time.MIDNIGHT)
        then
            -- Debug print. Useful when debugging and testing
            -- print("Spawned Dark Rider in: ", GetMobByID(darkRider[chosenRider]):getZone(), " on path #", chosenRider)
            SetServerVariable("[DARKRIDER]chosenRider", chosenRider)
            SetServerVariable("[DARKRIDER]isSpawned", 1)
            GetMobByID(darkRider[chosenRider]):spawn()
        end

        -- Despawn Hoofprints
        if GetServerVariable("[DARKRIDER]hoofprintDespawn") < os.time() then
            for _, id in pairs(eraHoofprintTable) do
                GetNPCByID(id):setStatus(xi.status.DISAPPEAR)
            end
        end

    -- Handle hoofprint spawning without the Dark Rider implementation
    else
        if GetServerVariable("[HOOFPRINT]respawnTime") < os.time() then
            local zone = math.random(1, 4)

            for _, id in pairs (hoofprintTable[zone]) do
                local spawn     = hoofprintSpawnTable[zone][math.random(1, #hoofprintSpawnTable)]
                local hoofprint = GetNPCByID(id)

                if hoofprint == nil then
                    return
                end

                if hoofprint:getStatus() ~= xi.status.NORMAL then
                    SetServerVariable("[DARKRIDER]respawnTime", respawnTime)
                    hoofprint:setPos(spawn)
                    hoofprint:setStatus(xi.status.NORMAL)

                    -- Only update despawn time if we haven't already
                    if GetServerVariable("[DARKRIDER]hoofprintDespawn") < hoofprintDespawn then
                        SetServerVariable("[DARKRIDER]hoofprintDespawn", hoofprintDespawn)
                    end

                    return
                end
            end
        end

        -- Despawn Hoofprints
        if GetServerVariable("[DARKRIDER]hoofprintDespawn") < os.time() then
            for zone = 1, #hoofprintTable do
                for _, id in pairs(hoofprintTable[zone]) do
                    local hoofprint = GetNPCByID(id)

                    if hoofprint == nil then
                        return
                    end

                    hoofprint:setStatus(xi.status.DISAPPEAR)
                end
            end
        end
    end
end

xi.dark_rider.onRiderInitialize = function(mob)
    mob:setMobMod(xi.mobMod.DONT_ROAM_HOME, 1)
    mob:setMobMod(xi.mobMod.NO_WIDESCAN, 1)
    mob:setMod(xi.mod.UDMGBREATH, -8500)
    mob:setMod(xi.mod.UDMGRANGE, -8500)
    mob:setMod(xi.mod.UDMGMAGIC, -8500)
    mob:setMod(xi.mod.UDMGPHYS, -8500)
    mob:setMod(xi.mod.FASTCAST, 100)
    mob:setMod(xi.mod.REGAIN, 500)
    mob:setUnkillable(true)
    mob:addImmunity(65535) -- Immune to everything
end

xi.dark_rider.onRiderSpawn = function(mob, pathNodes)
    local chosenPath = math.random(1, #pathNodes)
    local path       = pathNodes[chosenPath]

    mob:setBehaviour(bit.bor(mob:getBehaviour(), xi.behavior.NO_TURN))
    mob:setLocalVar("chosenPath", chosenPath)
    mob:setPos(path[1])
    mob:pathThrough(path, xi.path.flag.PATROL)

    -- Spawn minions along chosen path
    for i = 1, 6 do
        local minion = GetMobByID(mob:getID() + i)
        local spawn = path[math.random(1, #path)]

        minion:setSpawn(spawn.x, spawn.y, spawn.z)
        minion:spawn()
    end
end

-- Despawn at the end of the path
xi.dark_rider.onRiderRoam = function(mob, pathNodes)
    if mob:checkDistance(pathNodes[mob:getLocalVar("chosenPath")][#pathNodes]) <= 5 then
        DespawnMob(mob:getID())
    end
end

xi.dark_rider.onMobEngaged = function(mob, target)
    mob:castSpell(xi.magic.spell.DEATH, target)
end

xi.dark_rider.onRiderDisengage = function(mob, pathNodes)
    mob:pathThrough(pathNodes[mob:getLocalVar("chosenPath")], xi.path.flag.PATROL)
end

xi.dark_rider.onRiderDespawn = function(mob, pathNodes)
    local chosenRider    = mob:getLocalVar("chosenPath")
    local hoofprintSpawn = pathNodes[chosenRider][math.random(1, #pathNodes[chosenRider])]
    local hoofprint      = GetNPCByID(eraHoofprintTable[chosenRider])

    hoofprint:setPos(hoofprintSpawn)
    hoofprint:setStatus(xi.status.NORMAL)

    SetServerVariable("[DARKRIDER]hoofprintDespawn", hoofprintDespawn)
    SetServerVariable("[DARKRIDER]respawnTime", eraRespawnTime)
    SetServerVariable("[DARKRIDER]isSpawned", 0)

    -- Despawn Minions
    for i = 1, 6 do
        if GetMobByID(mob:getID() + i):isSpawned() then
            DespawnMob(mob:getID() + i)
        end
    end
end
