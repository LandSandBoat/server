-----------------------------------
-- Rescue! A Moogle's Labor of Love
-- A Moogle Kupo d'Etat M9
-- !addmission 10 8
-- Geologist cutscene args : csid, progress, has QC map: 1 or 0, markerset: 1-10
-- Goblin Geologist        : !pos -737 -6 -550 208
-- STONE_OF_SURYA          : !addkeyitem 1145
-- STONE_OF_CHANDRA        : !addkeyitem 1146
-- STONE_OF_MANGALA        : !addkeyitem 1147
-- STONE_OF_BUDHA          : !addkeyitem 1148
-- STONE_OF_BRIHASPATI     : !addkeyitem 1149
-- STONE_OF_SHUKRA         : !addkeyitem 1150
-- STONE_OF_SHANI          : !addkeyitem 1151
-- STONE_OF_RAHU           : !addkeyitem 1152
-- STONE_OF_KETU           : !addkeyitem 1153
-- NAVARATNA_TALISMAN      : !addkeyitem 1158
-----------------------------------
local ID = zones[xi.zone.QUICKSAND_CAVES]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.AMK, xi.mission.id.amk.RESCUE_A_MOOGLES_LABOR_OF_LOVE)

mission.reward =
{
    nextMission = { xi.mission.log_id.AMK, xi.mission.id.amk.ROAR_A_CAT_BURGLAR_BARES_HER_FANGS },
}

-- There are ten possible sets of QM locations that could be assigned to the player
-- that give the stone KIs. The table below holds the 10 sets that can be
-- randomly assigned, which stores the indices of the QM ids from a table
-- that is pulled from the database
local markerSets =
{
    { 1, 2, 5, 7,  8,  11, 14, 19, 20 },
    { 3, 4, 6, 9,  11, 13, 16, 17, 18 },
    { 2, 6, 7, 8,  10, 12, 15, 19, 20 },
    { 1, 3, 4, 5,  8,  9,  10, 17, 18 },
    { 2, 4, 7, 11, 12, 13, 15, 16, 20 },
    { 1, 3, 5, 6,  8,  9,  14, 18, 19 },
    { 2, 5, 7, 10, 11, 12, 15, 16, 17 },
    { 1, 3, 4, 6,  8,  13, 14, 17, 20 },
    { 2, 4, 7, 9,  10, 11, 16, 18, 19 },
    { 3, 5, 6, 12, 13, 14, 15, 18, 20 },
}

local getMarkerSet = function(player)
    -- markerSet is the setIndex of a random table within markerSets defined above
    local markerSet = player:getCharVar('Mission[10][8]markerSet')
    if markerSet == 0 then
        markerSet = math.random(1, #markerSets)
        player:setCharVar('Mission[10][8]markerSet', markerSet)
    end

    return markerSet
end

local hasAllStones = function(player)
    for keyItemId = xi.ki.STONE_OF_SURYA, xi.ki.STONE_OF_KETU do
        if not player:hasKeyItem(keyItemId) then
            return false
        end
    end

    return true
end

mission.sections =
{
    -- 0: Initiate quest, get markers
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:getCharVar('Mission[10][8]progress') == 0
        end,

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['Goblin_Geologist'] =
            {
                onTrigger = function(player, npc)
                    local hasMap = player:hasKeyItem(xi.ki.MAP_OF_THE_QUICKSAND_CAVES) and 1 or 0
                    return mission:progressEvent(100, 0, hasMap, getMarkerSet(player))
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    player:setCharVar('Mission[10][8]progress', 1)
                end,
            },
        },
    },

    -- 1: Have Markers, don't have all stones
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                player:getCharVar('Mission[10][8]progress') == 1 and
                not hasAllStones(player) and
                not player:hasKeyItem(xi.ki.NAVARATNA_TALISMAN)
        end,

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['Goblin_Geologist'] =
            {
                onTrigger = function(player, npc)
                    local hasMap = player:hasKeyItem(xi.ki.MAP_OF_THE_QUICKSAND_CAVES) and 1 or 0
                    return mission:progressEvent(100, 2, hasMap, getMarkerSet(player))
                end,
            },

            ['qm_amk'] =
            {
                onTrigger = function(player, npc)
                    -- Get set of markers assigned by geologist
                    local amkMarkerSet = player:getCharVar('Mission[10][8]markerSet')
                    if amkMarkerSet == 0 then
                        return mission:messageSpecial(ID.text.NOTHING_OUT_OF_ORDINARY)
                    end

                    -- Determine if QM triggered is in markerset
                    ---@type xi.keyItem
                    local keyItem
                    for idx, markerIdIndex in ipairs(markerSets[amkMarkerSet]) do
                        if npc:getID() == ID.npc.QM_AMK[markerIdIndex] then
                            keyItem = xi.ki.STONE_OF_SURYA + idx - 1
                        end
                    end

                    -- Give KI if QM is correct
                    if keyItem and not player:hasKeyItem(keyItem) then
                        return mission:keyItem(keyItem)
                    end
                end,
            },
        },
    },

    -- 2: Have all stones, award talisman
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission >= mission.missionId and
                hasAllStones(player) and
                not player:hasKeyItem(xi.ki.NAVARATNA_TALISMAN)
        end,

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['Goblin_Geologist'] =
            {
                onTrigger = function(player, npc)
                    local hasMap = player:hasKeyItem(xi.ki.MAP_OF_THE_QUICKSAND_CAVES) and 1 or 0
                    return mission:progressEvent(100, 1, hasMap, 0)
                end,
            },

            onEventFinish =
            {
                [100] = function(player, csid, option, npc)
                    for keyItemId = xi.ki.STONE_OF_SURYA, xi.ki.STONE_OF_KETU do
                        player:delKeyItem(keyItemId)
                    end

                    player:setCharVar('Mission[10][8]markerSet', 0)
                    npcUtil.giveKeyItem(player, xi.ki.NAVARATNA_TALISMAN)
                end,
            },
        },
    },

    -- 3: Have talisman, CS at shimmering cicle
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId and
                player:hasKeyItem(xi.ki.NAVARATNA_TALISMAN)
        end,

        [xi.zone.QUICKSAND_CAVES] =
        {
            ['Goblin_Geologist'] =
            {
                onTrigger = function(player, npc)
                    player:messageSpecial(ID.text.GRANT_YOU_EASY_ENTRANCE, xi.ki.NAVARATNA_TALISMAN)
                end,
            },
        },

        [xi.zone.CHAMBER_OF_ORACLES] =
        {
            ['Shimmering_Circle'] =
            {
                onTrigger = function(player, npc)
                    return mission:progressEvent(5)
                end
            },

            onEventFinish =
            {
                [5] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },
    },
}

return mission
