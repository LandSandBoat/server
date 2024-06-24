-----------------------------------
-- A Moogle Kupo d'Etat Helpers
-----------------------------------

xi = xi or {}
xi.amk = xi.amk or {}
xi.amk.helpers = xi.amk.helpers or {}

local validRegions = set{
    xi.region.RONFAURE,
    xi.region.ZULKHEIM,
    xi.region.NORVALLEN,
    xi.region.GUSTABERG,
    xi.region.DERFLAND,
    xi.region.SARUTABARUTA,
    xi.region.KOLSHUSHU,
    xi.region.ARAGONEU,
    xi.region.FAUREGANDI,
    xi.region.VALDEAUNIA,
    xi.region.QUFIMISLAND,
    xi.region.LITELOR,
    xi.region.KUZOTZ,
    xi.region.VOLLBOW,
    xi.region.ELSHIMOLOWLANDS,
    xi.region.ELSHIMOUPLANDS,
    xi.region.SANDORIA,
    xi.region.BASTOK,
    xi.region.WINDURST,
    xi.region.JEUNO,
    xi.region.DYNAMIS,
}

xi.amk.helpers.helmTrade = function(player, helmType, broke)
    local amkChance = 5
    local regionId = player:getCurrentRegion()
    local helmMapping =
    {
        [xi.helmType.MINING] = xi.ki.STURDY_METAL_STRIP,
        [xi.helmType.LOGGING] = xi.ki.PIECE_OF_RUGGED_TREE_BARK,
        [xi.helmType.HARVESTING] = xi.ki.SAVORY_LAMB_ROAST,
    }

    if
        player:getCurrentMission(xi.mission.log_id.AMK) >= xi.mission.id.amk.WELCOME_TO_MY_DECREPIT_DOMICILE
    then
        if
            helmMapping[helmType] and
            validRegions[regionId] and
            math.random(1, 100) <= amkChance
        then
            npcUtil.giveKeyItem(player, helmMapping[helmType])
        end
    end
end

-- AMK 6 (index 5) - An Errand! The Professor's Price
-- Cardian orb KI logic: All or nothing drop of the orb is handled by
-- a local var that is set once by the first player is called by onMobDeath
-- The rest of the players in alliance get the same outcome as the first
xi.amk.helpers.cardianOrbDrop = function(mob, player, orb)
    if
        player == nil or
        player:getCurrentMission(xi.mission.log_id.AMK) < xi.mission.id.amk.AN_ERRAND_THE_PROFESSORS_PRICE
    then
        return
    end

    -- Chance of drop increases both based on size of party and level of mob killed
    if mob:getLocalVar('Mission[10][5]cardianOrbDrop') == 0 then
        local partySize = 0
        for _, member in pairs(player:getAlliance()) do
            if member:getZoneID() == xi.zone.OUTER_HORUTOTO_RUINS then
                partySize = partySize + 1
            end
        end

        -- Chance ranges from 4% to 25.8% (based on max mob lvl of 44)
        local dropChance = (3 * mob:getMainLvl()) + (30 * utils.clamp(partySize, 1, 6)) - 10
        local roll = math.random(1000)

        if roll < dropChance then
            mob:setLocalVar('Mission[10][5]cardianOrbDrop', 1)
        else
            mob:setLocalVar('Mission[10][5]cardianOrbDrop', 2)
        end
    end

    -- Give orb
    if mob:getLocalVar('Mission[10][5]cardianOrbDrop') == 1 then
        npcUtil.giveKeyItem(player, orb)
    end
end

-- AMK 7 (index 6) - Select/lookup the digging zone
local digZoneIds =
{
    xi.zone.LA_THEINE_PLATEAU,
    xi.zone.VALKURM_DUNES,
    xi.zone.JUGNER_FOREST,
    xi.zone.KONSCHTAT_HIGHLANDS,
    xi.zone.PASHHOW_MARSHLANDS,
    xi.zone.TAHRONGI_CANYON,
    xi.zone.BUBURIMU_PENINSULA,
    xi.zone.MERIPHATAUD_MOUNTAINS,
    xi.zone.THE_SANCTUARY_OF_ZITAH,
    xi.zone.YUHTUNGA_JUNGLE,
    xi.zone.YHOATOR_JUNGLE,
    xi.zone.WESTERN_ALTEPA_DESERT,
    xi.zone.EASTERN_ALTEPA_DESERT,
}

xi.amk.helpers.digSites =
{
    [xi.zone.LA_THEINE_PLATEAU] =
    {
        eventID = 0,
        spots =
        {
            { x = 614.670, z = -427.080 },  -- (L-10)
            { x = -310.800, z = 47.260 },   -- (F-7)
            { x = -351.320, z = -167.000 }, -- (F-9)
            { x = -208.850, z = -43.290 },  -- (G-8)
            { x = -698.450, z = 209.590 },  -- (D-7)
            { x = -197.040, z = 275.560 },  -- (G-6) (NW corner of carby circle)
            { x = 489.060, z = 472.610 },   -- (K-5) (on  a small gray patchin the grass)
            { x = 528.760, z = -433.580 },  -- (K-10) (SE corner bottom of ramp)
            { x = -191.890, z = -472.910 }, -- (G-11) (small gray plot near edge of cliffe
            { x = 107.780, z = -575.280 },  -- (I-11) (slightly to left of lone tree on the map)
        },
    },
    [xi.zone.VALKURM_DUNES] =
    {
        eventID = 1,
        spots =
        {
            { x = -718.320, z = 131.920 }, -- (B-7)
            { x = 201.800, z = -70.300 },  -- (H-8)
            { x = -261.660, z = 154.590 }, -- (E-7)
            { x = -514.010, z = 125.600 }, -- (D-7)
            { x = -386.190, z = 317.570 }, -- (D-6) (ne corner near tree)
            { x = 615.06, z = 124.010 },   -- (J-7) (5 yalms from flowers near a large rock)
            { x = 662.250, z = -68.980 },  -- (K-8) (on corner of road)
            { x = -80.900, z = 181.840 },  -- (F-7) (next to root closest to trees)
        },
    },
    [xi.zone.JUGNER_FOREST] =
    {
        eventID = 2,
        spots =
        {
            { x = 514.850, z = 320.160 },   -- (K-6)
            { x = -273.420, z = 207.460 },  -- (G-7) (nw corner)
            { x = -242.710, z = -68.550 },  -- (G-8) (SW corner)
            { x = -275.370, z = -157.800 }, -- (G-9) (W side)
            { x = 114.150, z = 476.240 },   -- (I-5)
            { x = 117.450, z = -207.740 },  -- (I-9)
            { x = 258.960, z = 504.140 },   -- (J-5)
            { x = 591.460, z = 230.220 },   -- (L-7)
        },
    },
    [xi.zone.KONSCHTAT_HIGHLANDS] =
    {
        eventID = 3,
        spots =
        {
            { x = -424.130, z = 300.000 },  -- (E-6)
            { x = -463.780, z = -112.270 }, -- (E-9) (center a bit NW of big rock)
            { x = -250.490, z = 569.500 },  -- (F-5)
            { x = -190.000, z = -190.000 }, -- (G-9)
            { x = -115.810, z = -640.600 }, -- (G-12)
            { x = 473.570, z = 565.430 },   -- (K-5)
            { x = 469.660, z = 170.000 },   -- (K-7)
            { x = 36.570, z = 477.320 },    -- (H-5)
            { x = 62.150, z = -549.440 },   -- (H-12)
            { x = 246.900, z = 634.040 },   -- (J-4)
        },
    },
    [xi.zone.PASHHOW_MARSHLANDS] =
    {
        eventID = 4,
        spots =
        {
            { x = 620.090, z = 228.850 },   -- (L-7)
            { x = 488.390, z = 400.000 },   -- (K-6)
            { x = 219.090, z = 144.480 },   -- (I-7)
            { x = 185.250, z = 67.920 },    -- (I-8)
            { x = -22.820, z = 341.160 },   -- (H-6)
            { x = -169.300, z = 123.150 },  -- (G-7/8)
            { x = -362.290, z = 512.750 },  -- (F-5)
            { x = -394.710, z = -230.800 }, -- (E/F-10)
            { x = 422.530, z = -301.460 },  -- (K-10)
        },
    },
    [xi.zone.TAHRONGI_CANYON] =
    {
        eventID = 5,
        spots =
        {
            { x = 0.000, z = 565.630 },     -- (H-4) (Center)
            { x = 0.000, z = -163.160 },    -- (H-9)
            { x = -42.080, z = -398.800 },  -- (H-10)
            { x = -423.860, z = -185.390 }, -- (E-9)
            { x = -205.620, z = 542.280 },  -- (G-4)
            { x = 80.820, z = 121.230 },    -- (I-7)
            { x = 267.400, z = 78.200 },    -- (J-7)
            { x = 115.480, z = -206.400 },  -- (I-9)
            { x = 290.840, z = -344.020 },  -- (J-10) SW corner near a green patch
            { x = -369.270, z = 390.010 },  -- (F-5) SW corner on a green patch
            { x = -197.830, z = -153.650 }, -- (G-9) NW corner
            { x = -306.550, z = 265.430 },  -- (F-6) directly on center of grid
        },
    },
    [xi.zone.BUBURIMU_PENINSULA] =
    {
        eventID = 6,
        spots =
        {
            { x = -241.800, z = -271.150 }, -- (G-9) Near the song runes
            { x = -444.840, z = -263.150 }, -- (E-9)
            { x = -332.890, z = 246.850 },  -- (F-6)
            { x = -313.480, z = -107.170 }, -- (F-8) Near group of cacti
            { x = 392.490, z = 314.650 },   -- (J-6) NE corner
            { x = 392.970, z = 157.610 },   -- (J-7) NE corner
            { x = -32.940, z = 251.870 },   -- (H-6) Green patch on ground
            { x = -275.140, z = -258.90 },  -- (F-9) Center of grid (kind of impossible)
            { x = 426.50, z = -231.660 },   -- (K-9) Few feet west of sign post
        },
    },
    [xi.zone.MERIPHATAUD_MOUNTAINS] =
    {
        eventID = 7,
        spots =
        {
            { x = 528.210, z = 632.550 },  -- (J-4)
            { x = 189.600, z = -490.170 }, -- (H-11)
            { x = 650.320, z = -349.700 }, -- (K-10)
            { x = 631.820, z = 133.470 },  -- (K-7)
            { x = -470.700, z = -29.390 }, -- (D-8)
            { x = -516.070, z = 306.270 }, -- (D-6) W of center
            { x = 112.600, z = 555.390 },  -- (H-5) NW corner
            { x = -465.640, z = -296.50 }, -- (D-10)
            { x = 164.510, z = 165.470 },  -- (H-7) Middle on top of little ledge
        },
    },
    [xi.zone.THE_SANCTUARY_OF_ZITAH] =
    {
        eventID = 8,
        spots =
        {
            { x = -439.047, z = 122.349 },  -- (E-8)
            { x = -343.491, z = 133.725 },  -- (F-8)
            { x = -177.383, z = -279.362 }, -- (G-10)
            { x = 13.719, z = 88.664 },     -- (H-8)
            { x = 20.483, z = -146.541 },   -- (H-9)
            { x = 236.046, z = -273.312 },  -- (I-10)
            { x = 275.428, z = 159.460 },   -- (J-7)
        },
    },
    [xi.zone.YUHTUNGA_JUNGLE] =
    {
        eventID = 9,
        spots =
        {
            { x = -555.544, z = -80.067 },  -- (E-9)
            { x = -438.777, z = -388.825 }, -- (F-11)
            { x = -402.770, z = -259.826 }, -- (F-10)
            { x = -201.421, z = -438.868 }, -- (G-11)
            { x = 294.342, z = 211.039 },   -- (J-7)
            { x = 122.505, z = 432.139 },   -- (I-6)
            { x = -122.441, z = 444.200 },  -- (H-6)
            { x = -130.948, z = 203.126 },  -- (H-7)
        },
    },
    [xi.zone.YHOATOR_JUNGLE] =
    {
        eventID = 10,
        spots =
        {
            { x = -2.428, z = -359.037 },   -- (H-10)
            { x = -397.683, z = -260.857 }, -- (F-9) Under the log
            { x = -255.970, z = -123.890 }, -- (F-9) NE of tele
            { x = -385.761, z = -383.388 }, -- (F-10)
            { x = 186.28, z = -187.310 },   -- (I-9)
            { x = -83.513, z = 224.256 },   -- (G-7) Directly under the signpost
            { x = -231.969, z = -144.198 }, -- (G-9) Just east of telepoint
        },
    },
    [xi.zone.WESTERN_ALTEPA_DESERT] =
    {
        eventID = 11,
        spots =
        {
            { x = -811.000, z = -396.380 }, -- (D-10)
            { x = -637.710, z = -676.310 }, -- (E-11)
            { x = -429.9, z = -33.000 },    -- (F-7)
            { x = -165.390, z = -172.490 }, -- (H-8)
            { x = 90.920, z = 50.630 },     -- (I-7)
            { x = 567.740, z = 230.710 },   -- (L-6)
            { x = 571.580, z = -10.900 },   -- (L-7) SE corner between two large cacti
            { x = 674.245, z = 46.084 },    -- (M-7)
            { x = -3.805, z = 348.229 },    -- (I-5)
            { x = 334.699, z = 105.761 },   -- (K-7) NW corner
        },
    },
    [xi.zone.EASTERN_ALTEPA_DESERT] =
    {
        eventID = 12,
        spots =
        {
            { x = -309.358, z = 49.217 },   -- (F-8) NW corner
            { x = 419.165, z = 38.675 },    -- (J-8) NE of center
            { x = 368.639, z = -208.379 },  -- (J-9) SW corner
            { x = 37.012, z = -393.275 },   -- (H-10) SW corner
            { x = -197.142, z = 285.642 },  -- (F-6) SE corner
            { x = 20.214, z = 73.494 },     -- (H-8) NW corner
            { x = -189.196, z = 32.195 },   -- (F-8) NE corner
            { x = 85.507, z = 313.316 },    -- (H-6) Center
            { x = 469.810, z = 222.405 },   -- (J/K-7) Upper third of square
            { x = -215.823, z = -181.996 }, -- (F-9) Center
        },
    },
}

xi.amk.helpers.getDiggingZone = function(player)
    -- Returns zone id of 1 of the 13 possible zones, and sets variable
    local diggingZone = player:getCharVar('Mission[10][6]diggingZone')

    if xi.amk.helpers.digSites[diggingZone] == nil then
        -- 1  = La Theine Plateau
        -- 2  = Valkurm Dunes
        -- 3  = Jugner Forest
        -- 4  = Konschtat Highlands
        -- 5  = Pashhow Marshlands
        -- 6  = Tahrongi Canyon
        -- 7  = Buburimu Peninsula
        -- 8  = Meriphataud Mountains
        -- 9  = The Sanctuary of Zi'tah
        -- 10 = Yuhtunga Jungle
        -- 11 = Yhoator Jungle
        -- 12 = Western Altepa Desert
        -- 13 = Eastern Altepa Desert
        diggingZone = digZoneIds[math.random(#digZoneIds)]
        player:setCharVar('Mission[10][6]diggingZone', diggingZone)
    end

    return diggingZone
end

xi.amk.helpers.tryRandomlyPlaceDiggingLocation = function(player)
    -- Randomly selects a dig spot every time player zones into an AMK7 zone
    local diggingZoneId = xi.amk.helpers.getDiggingZone(player)
    local diggingSiteTable = xi.amk.helpers.digSites[diggingZoneId].spots
    player:setLocalVar('Mission[10][6]diggingSpot', math.random(#diggingSiteTable))
end

xi.amk.helpers.chocoboDig = function(player, zoneId, text)
    local diggingZoneId = xi.amk.helpers.getDiggingZone(player)
    local diggingSpot = player:getLocalVar('Mission[10][6]diggingSpot')
    local diggingSiteTable = xi.amk.helpers.digSites[diggingZoneId].spots

    if
        player:hasKeyItem(xi.ki.MOLDY_WORM_EATEN_CHEST) or
        zoneId ~= diggingZoneId
    then
        return false
    end

    local playerPos = player:getPos()

    -- Get target position from the digSites table
    local targetPos = diggingSiteTable[diggingSpot]
    local targetX   = targetPos.x
    local targetZ   = targetPos.z

    local distance = player:checkDistance(targetX, playerPos.y, targetZ)

    -- Success!
    if distance < 5 then
        npcUtil.giveKeyItem(player, xi.ki.MOLDY_WORM_EATEN_CHEST)
        return true
    end

    -- Angle between points
    -- NOTE: This is mapped to 0-255
    local angle = player:getWorldAngle(targetX, playerPos.y, targetZ)

    -- Map angle from 0-255 to 0-7 for the messageSpecial arg, with a small offset for cardinal direction
    local offset = 255 / 8
    local direction = math.floor(((7 - 0) / (255 - 0)) * ((angle + offset) - 0))

    -- Your Chocobo is pulling at the bit
    -- You Sense that it is leading you to the [compass direction]
    player:messageSpecial(text.AMK_DIGGING_OFFSET + 6, direction)

    -- No additional hint (Approx: 201'+ from target)
    if distance > 200 then
    -- You have a hunch this area would be favored by moogles... (Approx. 81-200' from target or two map grids)
    elseif distance > 120 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 5, direction)
    -- You have a vague feeling that a moogle would enjoy traversing this terrain... (Approx. 51-80' from target)
    elseif distance > 80 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 4, direction)
    -- You suspect that the scenery around here would be to a moogle's liking... (Approx. 21-50' from target)
    elseif distance > 50 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 3, direction)
    -- You have a feeling your moogle friend has been through this way... (Approx. 11-20' from target)
    elseif distance > 20 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 2, direction)
    -- You get the distinct sense that your moogle friend frequents this spot... (Approx. 5-10' from target)
    elseif distance > 10 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 1, direction)
    -- You are convinced that your moogle friend has been digging in the immediate vicinity. (Less than 5' from target)
    elseif distance > 5 then
        player:messageSpecial(text.AMK_DIGGING_OFFSET + 0, direction)
    end

    return false
end

-- Mission 13 (index 12) - Puzzles!!!
-----------------------------------
-- Puzzle 1 - Elemental Numbers!
-----------------------------------
xi.amk.helpers.pipSets =
{
    -- [Answer]: 0-9
    -- {
    --     [1] = NW, [4] = NE,
    --     [2] = W,  [5] = E,
    --     [3] = SW, [6] = SE,
    -- },
    [0] =
    {
        [1] = 4, [4] = 3,
        [2] = 5, [5] = 2,
        [3] = 4, [6] = 3,
    },

    [1] =
    {
        [1] = 1, [4] = 3,
        [2] = 1, [5] = 4,
        [3] = 1, [6] = 3,
    },

    [2] =
    {
        [1] = 0, [4] = 7,
        [2] = 5, [5] = 6,
        [3] = 4, [6] = 3,
    },

    [3] =
    {
        [1] = 2, [4] = 3,
        [2] = 5, [5] = 4,
        [3] = 2, [6] = 3,
    },

    [4] =
    {
        [1] = 6, [4] = 3,
        [2] = 5, [5] = 4,
        [3] = 1, [6] = 3,
    },

    [5] =
    {
        [1] = 1, [4] = 0,
        [2] = 2, [5] = 3,
        [3] = 5, [6] = 4,
    },

    [6] =
    {
        [1] = 1, [4] = 0,
        [2] = 2, [5] = 3,
        [3] = 3, [6] = 4,
    },

    [7] =
    {
        [1] = 4, [4] = 3,
        [2] = 1, [5] = 4,
        [3] = 1, [6] = 3,
    },

    [8] =
    {
        [1] = 4, [4] = 3,
        [2] = 5, [5] = 4,
        [3] = 4, [6] = 3,
    },

    [9] =
    {
        [1] = 4, [4] = 3,
        [2] = 5, [5] = 4,
        [3] = 1, [6] = 3,
    },
}

xi.amk.helpers.puzzleOneOnTrigger = function(player, npc, mission, offset)
    local pipSet = mission:getLocalVar(player, '[p1]pipSet') - 1
    local pos = npc:getPos()
    local element = xi.amk.helpers.pipSets[pipSet][offset]

    return mission:progressEvent(509 + offset,
        pos.x * 1000,
        pos.z * 1000,
        pos.y * 1000,
        element,
        xi.ki.MAP_OF_THE_NORTHLANDS_AREA
    )
end

-----------------------------------
-- Puzzle 2 - Trivia!
-- CSID 200 trigger params: question number, correct answer (stoogeNum), previous stooge, stooge location, time limit, current time, player ID?
-- CSID 200 update params:  answer 1, location 1, answer 2, location 2, cs moogle location, time limit, current time, player id?
-- trivia locations: 0 = option one, 1 = option two, 2 = option three
-- Stooge CS locations: 1 = option one, 2 = option two, 3 = option three
-- Variables are named as 'option' if 0-indexed, as 'stooge' if 1-indexed
-----------------------------------
local xarc = zones[xi.zone.XARCABARD]

-- returns -1 or 1 to offset the wrong answer randomly
local randomSign = function()
    return math.random(1, 2) == 1 and 1 or -1
end

-- Structured list of the trivia questions
xi.amk.helpers.triviaQuestions =
{
    -- 0 : Add your current hit points to your current magic points, and you get…?
    [0] = function(player)
        local right = player:getHP() + player:getMP()
        local wrong = right + (randomSign() * math.floor(right / 2))

        if wrong == right then
            -- player has 1 hp 0 mp
            wrong = 2
        end

        return { right, wrong }
    end,

    -- 1 : The sum total of each and every one of your job levels is?
    [1] = function(player)
        local jobTotal = 0
        for i = xi.job.WAR, xi.job.RUN do
            jobTotal = jobTotal + player:getJobLevel(i)
        end

        local right = jobTotal -- minimum 15
        local wrong = right + (randomSign() * math.floor(right / 2))
        return { right, wrong }
    end,

    -- 2 : The sum total of each of your crafting skill levels is?
    [2] = function(player)
        local craftTotal = 0
        for craft = xi.skill.FISHING, xi.skill.SYNERGY do
            craftTotal = craftTotal + math.floor(player:getCharSkillLevel(craft) / 10)
        end

        local right = craftTotal
        local wrong = right + (randomSign() * math.floor(right / 2))

        if wrong == right then
            -- right is 0 or 1
            if wrong == 0 then
                wrong = 1
            elseif wrong == 1 then
                wrong = wrong + randomSign()
            end
        end

        return { right, wrong }
    end,

    -- 3 : The sum total of each one of your current elemental resistance levels is?
    [3] = function(player)
        local elementTotal = 0
        for mod = xi.mod.FIRE_MEVA, xi.mod.DARK_MEVA do
            elementTotal = elementTotal + player:getMod(mod)
        end

        local right = elementTotal
        local wrong = right + (randomSign() * math.floor(right / 2))

        if wrong == right then
            -- right is 0 or 1
            wrong = wrong + randomSign()
        end

        return { right, wrong }
    end,

    -- 4 : The total number of foes you’ve felled is?
    [4] = function(player)
        local right = player:getHistory(xi.history.ENEMIES_DEFEATED)
        local wrong = right + (randomSign() * math.floor(right / 2))

        if wrong == right then
            -- right is 0 or 1
            wrong = right + 1
        end

        return { right, wrong }
    end,

    -- 5 : Multiply your current attack and defense, and what do you get!?
    [5] = function(player)
        local right = player:getStat(xi.mod.ATT) * player:getStat(xi.mod.DEF)
        local wrong = right + (randomSign() * math.floor(right / 2))

        if wrong == right then
            -- right is 0 or 1
            if wrong == 0 then
                wrong = 1
            elseif wrong == 1 then
                wrong = wrong + randomSign()
            end
        end

        return { right, wrong }
    end,

    -- 6 : The total number of times you’ve strolled through the doors of your Mog House is?
    [6] = function(player)
        local right = player:getHistory(xi.history.MH_ENTRANCES)
        local wrong = right + (randomSign() * math.floor(right / 2))

        return { right, wrong }
    end,

    -- 7 : The total number of times you’ve been incapacitated by your enemies is?
    [7] = function(player)
        local right = player:getHistory(xi.history.TIMES_KNOCKED_OUT)
        local wrong = right + (randomSign() * math.floor(right / 2))

        if wrong == right then
            -- right is 0 or 1
            if wrong == 0 then
                wrong = 1
            elseif wrong == 1 then
                wrong = wrong + randomSign()
            end
        end

        return { right, wrong }
    end,

    -- 8 : The total number of times you’ve participated in a party is?
    [8] = function(player)
        local right = player:getHistory(xi.history.JOINED_PARTIES)
        local wrong = right + (randomSign() * math.floor(right / 2))

        if wrong == right then
            -- right is 0 or 1
            if wrong == 0 then
                wrong = 1
            elseif wrong == 1 then
                wrong = wrong + randomSign()
            end
        end

        return { right, wrong }
    end,

    -- 9 : The total number of times you’ve affiliated yourself with an alliance is?
    [9] = function(player)
        local right = player:getHistory(xi.history.JOINED_ALLIANCES)
        local wrong = right + (randomSign() * math.floor(right / 2))

        if wrong == right then
            -- right is 0 or 1
            if wrong == 0 then
                wrong = 1
            elseif wrong == 1 then
                wrong = wrong + randomSign()
            end
        end

        return { right, wrong }
    end,
}

local assignRandomTriviaQuestions = function(player, mission)
    local questions = {}
    for i, _ in pairs(xi.amk.helpers.triviaQuestions) do
        table.insert(questions, i)
    end

    for i = 1, 3 do
        local index = math.random(1, #questions)
        mission:setLocalVar(player, '[p2]question' .. i, questions[index])
        table.remove(questions, index)
    end
end

local resetPuzzleVars = function(player, mission)
    mission:setLocalVar(player, '[p2]progress', 0)
    mission:setLocalVar(player, '[p2]timeLimit', 0)
    mission:setLocalVar(player, '[p2]question1', 0)
    mission:setLocalVar(player, '[p2]question2', 0)
    mission:setLocalVar(player, '[p2]question3', 0)
    mission:setLocalVar(player, '[p2]correctStooge', 0)
    mission:setLocalVar(player, '[p2]previousStooge', 0)
end

local stooges =
{
    -- Answer numbers are 0-indexed references to Option_[One/two/three].
    -- AnswerOne/Two are used in onEventUpdate to determine which Option
    -- to point to for wrong and right answers. ie: answerOne = 0 points to Option_One
    -- StoogeNum is used in onEventTrigger to determine which npc visual
    -- to show
    [xarc.npc.OPTION_ONE]   = { stoogeNum = 1, answerOne = 1, answerTwo = 2 },
    [xarc.npc.OPTION_TWO]   = { stoogeNum = 2, answerOne = 0, answerTwo = 2 },
    [xarc.npc.OPTION_THREE] = { stoogeNum = 3, answerOne = 0, answerTwo = 1 },
}

xi.amk.helpers.puzzleTwoOnTrigger = function(player, npc, mission)
    local p2Progress = mission:getLocalVar(player, '[p2]progress')

    -- Starting puzzle, assign questions
    if p2Progress == 0 then
        p2Progress = 1
        mission:setLocalVar(player, '[p2]progress', p2Progress)
        assignRandomTriviaQuestions(player, mission)
    end

    -- Puzzle already beaten, show flavor text
    if
        player:hasKeyItem(xi.ki.GAUNTLET_CHALLENGE_KUPON) or
        player:getCharVar('Mission[10][12]progress') == 3
    then
        p2Progress = 10
    end

    local currentQuestion = mission:getLocalVar(player, '[p2]question' .. p2Progress)
    local correctStooge = mission:getLocalVar(player, '[p2]correctStooge')
    local previousStooge = mission:getLocalVar(player, '[p2]previousStooge')
    local stoogeNum = stooges[npc:getID()].stoogeNum
    local timeLimit = mission:getLocalVar(player, '[p2]timeLimit')

    -- DEBUG
    -- player:PrintToPlayer(string.format("p2Progress: %s, time_limit: %s, currentQuestion: %s, correctStooge: %s, previousStooge: %s, stoogeNum: %s",
    --                                     p2Progress,     timeLimit,      currentQuestion,     correctStooge,       previousStooge,    stoogeNum))

    if previousStooge ~= stoogeNum then
        return mission:progressEvent(
            200,
            p2Progress,
            currentQuestion,
            correctStooge,
            previousStooge,
            stoogeNum,
            timeLimit,
            os.time()
        )
    end
end

xi.amk.helpers.puzzleTwoOnEventUpdate = function(player, csid, option, npc, mission)
    if option >= 1 and option <= 3 then
        local stooge = stooges[npc:getID()]
        local timeLimit = os.time() + 180 -- Three minutes
        local p2Progress = mission:getLocalVar(player, '[p2]progress')
        local currentQuestion = mission:getLocalVar(player, '[p2]question' .. p2Progress)
        local answers = xi.amk.helpers.triviaQuestions[currentQuestion](player)

        -- Right and wrong answer/stooge has to be randomized in terms of order given to updateEvent
        -- Randomize which of the two other options is correct.  Set vars to a default choice, then swap only when answerOne is 2
        local answerOne = math.random(1, 2)

        -- Default: answerOne == 1
        local correctOption = stooge.answerOne
        local answerTwo = 2

        if answerOne == 2 then
            correctOption = stooge.answerTwo
            answerTwo = 1
        end

        -- Store important information for next CS parameters
        mission:setLocalVar(player, '[p2]correctStooge', correctOption + 1) -- Stooge num is always 1 more than the option
        mission:setLocalVar(player, '[p2]timeLimit', timeLimit) -- Time limit - > 3 minutes fails
        mission:setLocalVar(player, '[p2]previousStooge', stooge.stoogeNum) -- this tells the stooge that he is or isn't supposed to talk

        player:updateEvent(
            answers[answerOne],
            stooge.answerOne,
            answers[answerTwo],
            stooge.answerTwo,
            currentQuestion,
            timeLimit,
            os.time()
        )
    elseif option == 11 then
        -- Incorrect Answer
        local randomFlavorText = math.random(1, 2)
        if randomFlavorText == 1 then
            player:messageSpecial(xarc.text.INCORRECT_NO_GIFTS)
        else
            player:messageSpecial(xarc.text.EXACTLY_WRONG)
        end
    end
end

xi.amk.helpers.puzzleTwoOnEventFinish = function(player, csid, option, npc, mission)
    local p2Progress = mission:getLocalVar(player, '[p2]progress')
    if csid == 200 then
        if option == 0 then
            -- lost the game, via time or wrong answer - reset vars
            resetPuzzleVars(player, mission)
        elseif option == 1 then
            mission:setLocalVar(player, '[p2]progress', p2Progress + 1)
        elseif option == 2 and p2Progress == 4 then
            -- Won game, reset all vars
            resetPuzzleVars(player, mission)
            npcUtil.giveKeyItem(player, xi.ki.GAUNTLET_CHALLENGE_KUPON)
            player:delKeyItem(xi.ki.TRIVIA_CHALLENGE_KUPON)

            -- Advance to puzzle 3
            mission:setVar(player, 'progress', 3)
        end
    end
end

xi.amk.helpers.puzzleFourOnEventFinish = function(player, csid, option, npc, mission)
    if option == 1 then
        mission:setVar(player, 'cohortIdx', 0)
        npcUtil.giveKeyItem(player, xi.ki.MEGA_BONANZA_KUPON)
        player:delKeyItem(xi.ki.FESTIVAL_SOUVENIR_KUPON)

        -- Advance to final fight
        mission:setVar(player, 'progress', 5)
    end
end
