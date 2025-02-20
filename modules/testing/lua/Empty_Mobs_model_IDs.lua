-----------------------------------
-- Add some test MOBs to GM_HOME (zone 210)
-----------------------------------
require('modules/module_utils')
require('scripts/zones/GM_Home/Zone')
-----------------------------------
local m = Module:new('promyvion_model_elements')

-- Model elemental order in groups of 8:
-- Dark, Water, Lightning, Earth, Light, Fire, Ice, Wind

local mobInfo =
{ -- [Index] = { mob_name, model_ID, animation_sub }
    -- Wanderer-Type model.
    [ 1] = { 'Wanderer-1106-5', 1106,  5 },
    [ 2] = { 'Wanderer-1106-6', 1106,  6 },
    [ 3] = { 'Wanderer-1107-5', 1107,  5 },
    [ 4] = { 'Wanderer-1107-6', 1107,  6 },
    [ 5] = { 'Wanderer-1108-5', 1108,  5 },
    [ 6] = { 'Wanderer-1108-6', 1108,  6 },
    [ 7] = { 'Wanderer-1110-5', 1110,  5 },
    [ 8] = { 'Wanderer-1110-6', 1110,  6 },
    [ 9] = { 'Stray-1106-13',   1106, 13 },
    [10] = { 'Stray-1106-14',   1106, 14 },
    [11] = { 'Stray-1107-13',   1107, 13 },
    [12] = { 'Stray-1107-14',   1107, 14 },
    [13] = { 'Stray-1108-13',   1108, 13 },
    [14] = { 'Stray-1108-14',   1108, 14 },
    [15] = { 'Stray-1110-13',   1110, 13 },
    [16] = { 'Stray-1110-14',   1110, 14 },
    [17] = { 'Drifter-3614-5',  3614,  5 },
    [18] = { 'Drifter-3614-6',  3614,  6 },
    [19] = { 'Drifter-3615-5',  3615,  5 },
    [20] = { 'Drifter-3615-6',  3615,  6 },
    [21] = { 'Drifter-3616-5',  3616,  5 },
    [22] = { 'Drifter-3616-6',  3616,  6 },
    [23] = { 'Drifter-3617-5',  3617,  5 },
    [24] = { 'Drifter-3617-6',  3617,  6 },

    -- Weeper-Type model.
    [25] = { 'Weeper-1112-5',   1112, 5 },
    [26] = { 'Weeper-1112-6',   1112, 6 },
    [27] = { 'Weeper-1113-5',   1113, 5 },
    [28] = { 'Weeper-1113-6',   1113, 6 },
    [29] = { 'Weeper-1114-5',   1114, 5 },
    [30] = { 'Weeper-1114-6',   1114, 6 },
    [31] = { 'Weeper-1115-5',   1115, 5 },
    [32] = { 'Weeper-1115-6',   1115, 6 },
    [33] = { 'Lamenter-3619-5', 3619, 5 },
    [34] = { 'Lamenter-3619-6', 3619, 6 },
    [35] = { 'Lamenter-3620-5', 3620, 5 },
    [36] = { 'Lamenter-3620-6', 3620, 6 },
    [37] = { 'Lamenter-3621-5', 3621, 5 },
    [38] = { 'Lamenter-3621-6', 3621, 6 },
    [39] = { 'Lamenter-3622-5', 3622, 5 },
    [40] = { 'Lamenter-3622-6', 3622, 6 },

    -- Seether-Type model.
    [41] = { 'Seether-1117-5', 1117, 5 },
    [42] = { 'Seether-1117-6', 1117, 6 },
    [43] = { 'Seether-1119-5', 1119, 5 },
    [44] = { 'Seether-1119-6', 1119, 6 },
    [45] = { 'Seether-1120-5', 1120, 5 },
    [46] = { 'Seether-1120-6', 1120, 6 },
    [47] = { 'Seether-1121-5', 1121, 5 },
    [48] = { 'Seether-1121-6', 1121, 6 },
    [49] = { 'Rager-3624-5',   3624, 5 },
    [50] = { 'Rager-3624-6',   3624, 6 },
    [51] = { 'Rager-3625-5',   3625, 5 },
    [52] = { 'Rager-3625-6',   3625, 6 },
    [53] = { 'Rager-3626-5',   3626, 5 },
    [54] = { 'Rager-3626-6',   3626, 6 },
    [55] = { 'Rager-3627-5',   3627, 5 },
    [56] = { 'Rager-3627-6',   3627, 6 },

    -- Thinker
    [57] = { 'Thinker-1123-13', 1123, 13 },
    [58] = { 'Thinker-1123-14', 1123, 14 },
    [59] = { 'Thinker-1124-13', 1124, 13 },
    [60] = { 'Thinker-1124-14', 1124, 14 },
    [61] = { 'Thinker-1126-13', 1126, 13 },
    [62] = { 'Thinker-1126-14', 1126, 14 },
    [63] = { 'Thinker-1127-13', 1127, 13 },
    [64] = { 'Thinker-1127-14', 1127, 14 },
    -- [X] = { 'Cerebrator-1128-5', 1128, 5 },
    -- [X] = { 'Cerebrator-1128-6', 1128, 6 },

    -- Gorger
    [65] = { 'Gorger-1129-13', 1129, 13 },
    [66] = { 'Gorger-1129-14', 1129, 14 },
    [67] = { 'Gorger-1130-13', 1130, 13 },
    [68] = { 'Gorger-1130-14', 1130, 14 },
    [69] = { 'Gorger-1131-13', 1131, 13 },
    [70] = { 'Gorger-1131-14', 1131, 14 },
    [71] = { 'Gorger-1132-13', 1132, 13 },
    [72] = { 'Gorger-1132-14', 1132, 14 },
    -- [X] = { 'Satiator-1133-5', 1133,  5 },
    -- [X] = { 'Satiator-1133-6', 1133,  6 },

    -- Craver
    [73] = { 'Craver-1134-13', 1134, 13 },
    [74] = { 'Craver-1134-14', 1134, 14 },
    [75] = { 'Craver-1135-13', 1135, 13 },
    [76] = { 'Craver-1135-14', 1135, 14 },
    [77] = { 'Craver-1137-13', 1137, 13 },
    [78] = { 'Craver-1137-14', 1137, 14 },
    [79] = { 'Craver-1138-13', 1138, 13 },
    [80] = { 'Craver-1138-14', 1138, 14 },
    -- [X] = { 'Coveter-1139-5', 1139,  5 },
    -- [X] = { 'Coveter-1139-6', 1139,  6 },
}

m:addOverride('xi.zones.GM_Home.Zone.onInitialize', function(zone)
    super(zone)

    for i = 1, #mobInfo do
        local mob = zone:insertDynamicEntity({
            objtype     = xi.objType.MOB,
            name        = mobInfo[i][1],
            groupId     = 5,
            groupZoneId = 154,
            onMobSpawn = function(mob)
                mob:setModelId(mobInfo[i][2])
                mob:setAnimationSub(mobInfo[i][3])
                mob:setMobMod(xi.mobMod.NO_MOVE, 1)
            end,

            releaseIdOnDisappear  = true,
            specialSpawnAnimation = true,
        })

        -- Math the grid.
        local xPos = 5 * (1 + math.floor((i - 1) / 8))
        local ref  = i
        while ref > 8 do
            ref = ref - 8
        end

        local zPos = (ref - 1) * 5

        mob:setSpawn(xPos, 0, zPos, 128)
        mob:spawn()
    end
end)

return m
