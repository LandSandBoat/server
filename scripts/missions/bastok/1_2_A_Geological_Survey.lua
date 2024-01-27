-----------------------------------
-- A Geological Survey
-- Bastok M1-2
-----------------------------------
-- !addmission 1 1
-- Argus   : !pos 132.157 7.496 -2.187 236
-- Cleades : !pos -358 -10 -168 235
-- Malduc  : !pos 66.200 -14.999 4.426 237
-- Rashid  : !pos -8.444 -2 -123.575 234
-- Cid     : !pos -12 -12 1 237
-----------------------------------
local bastokMarketsID = zones[xi.zone.BASTOK_MARKETS]
local bastokMinesID   = zones[xi.zone.BASTOK_MINES]
local metalworksID    = zones[xi.zone.METALWORKS]
local portBastokID    = zones[xi.zone.PORT_BASTOK]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.GEOLOGICAL_SURVEY)

local handleAcceptMission = function(player, csid, option, npc)
    if option == 1 then
        mission:begin(player)
        player:messageSpecial(zones[player:getZoneID()].text.YOU_ACCEPT_THE_MISSION)
    end
end

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == xi.mission.id.nation.NONE and
                player:getNation() == mission.areaId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.BASTOK_MINES] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.METALWORKS] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            onEventFinish =
            {
                [1001] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.BASTOK_MARKETS] =
        {
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.ORIGINAL_MISSION_OFFSET + 3),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.ORIGINAL_MISSION_OFFSET + 3),
        },

        [xi.zone.DANGRUF_WADI] =
        {
            onEventFinish =
            {
                [10] = function(player, csid, option, npc)
                    if player:hasKeyItem(xi.ki.BLUE_ACIDITY_TESTER) then
                        player:delKeyItem(xi.ki.BLUE_ACIDITY_TESTER)
                        npcUtil.giveKeyItem(player, xi.ki.RED_ACIDITY_TESTER)
                    end
                end,

                [11] = function(player, csid, option, npc)
                    if player:hasKeyItem(xi.ki.BLUE_ACIDITY_TESTER) then
                        player:delKeyItem(xi.ki.BLUE_ACIDITY_TESTER)
                        npcUtil.giveKeyItem(player, xi.ki.RED_ACIDITY_TESTER)
                    end
                end,

                [12] = function(player, csid, option, npc)
                    if player:hasKeyItem(xi.ki.BLUE_ACIDITY_TESTER) then
                        player:delKeyItem(xi.ki.BLUE_ACIDITY_TESTER)
                        npcUtil.giveKeyItem(player, xi.ki.RED_ACIDITY_TESTER)
                    end
                end,
            },
        },

        [xi.zone.METALWORKS] =
        {
            ['Cid'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.RED_ACIDITY_TESTER) then
                        return mission:progressEvent(504)
                    elseif not player:hasKeyItem(xi.ki.BLUE_ACIDITY_TESTER) then
                        return mission:progressEvent(503)
                    else
                        return mission:event(502)
                    end
                end,
            },

            ['Malduc'] = mission:messageSpecial(metalworksID.text.ORIGINAL_MISSION_OFFSET + 3),

            onEventFinish =
            {
                [503] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.BLUE_ACIDITY_TESTER)
                end,

                [504] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.RED_ACIDITY_TESTER)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.ORIGINAL_MISSION_OFFSET + 3),
        },
    },
}

return mission
