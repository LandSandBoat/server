-----------------------------------
-- The Pirate's Cove
-- Bastok M6-2
-----------------------------------
-- !addmission 1 17
-- Argus      : !pos 132.157 7.496 -2.187 236
-- Cleades    : !pos -358 -10 -168 235
-- Malduc     : !pos 66.200 -14.999 4.426 237
-- Rashid     : !pos -8.444 -2 -123.575 234
-- Naji       : !pos 64 -14 -4 237
-- qm4        : !pos 171 0 -25 205
-- Gilgamesh  : !pos 122.452 -9.009 -12.052 252
-----------------------------------
local bastokMarketsID  = zones[xi.zone.BASTOK_MARKETS]
local bastokMinesID    = zones[xi.zone.BASTOK_MINES]
local ifritsCauldronID = zones[xi.zone.IFRITS_CAULDRON]
local metalworksID     = zones[xi.zone.METALWORKS]
local portBastokID     = zones[xi.zone.PORT_BASTOK]
-----------------------------------

local mission = Mission:new(xi.mission.log_id.BASTOK, xi.mission.id.bastok.THE_PIRATES_COVE)

mission.reward =
{
    gil = 40000,
    rank = 7,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 17 then
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
            ['Cleades'] = mission:messageSpecial(bastokMarketsID.text.EXTENDED_MISSION_OFFSET + 3),
        },

        [xi.zone.BASTOK_MINES] =
        {
            ['Rashid'] = mission:messageSpecial(bastokMinesID.text.EXTENDED_MISSION_OFFSET + 3),
        },

        [xi.zone.METALWORKS] =
        {
            ['Malduc'] = mission:messageSpecial(metalworksID.text.EXTENDED_MISSION_OFFSET + 3),

            ['Naji'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(761)
                    elseif missionStatus == 3 then
                        return mission:progressEvent(762)
                    end
                end,
            },

            onEventFinish =
            {
                [761] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [762] = function(player, csid, option, npc)
                    mission:complete(player)
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Argus'] = mission:messageSpecial(portBastokID.text.EXTENDED_MISSION_OFFSET + 3),
        },

        [xi.zone.NORG] =
        {
            ['Gilgamesh'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        npcUtil.tradeHasExactly(trade, xi.item.FRAG_ROCK)
                    then
                        return mission:progressEvent(99)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) == 1 then
                        return mission:progressEvent(98)
                    end
                end,
            },

            onEventFinish =
            {
                [98] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [99] = function(player, csid, option, npc)
                    player:confirmTrade()
                    player:setMissionStatus(mission.areaId, 3)
                end,
            },
        },

        [xi.zone.IFRITS_CAULDRON] =
        {
            ['qm4'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        npcUtil.tradeHasExactly(trade, xi.item.CHUNK_OF_ADAMAN_ORE) and
                        npcUtil.popFromQM(player, npc, { ifritsCauldronID.mob.PIRATES_COVE_NMS, ifritsCauldronID.mob.PIRATES_COVE_NMS + 1 }, { claim = false, hide = 900 })
                    then
                        player:confirmTrade()
                        GetMobByID(ifritsCauldronID.mob.PIRATES_COVE_NMS):lookAt(player:getPos()) -- Salamander
                        GetMobByID(ifritsCauldronID.mob.PIRATES_COVE_NMS + 1):updateClaim(player) -- Magma
                        return mission:messageSpecial(ifritsCauldronID.text.BAD_FEELING_ABOUT_PLACE)
                    end
                end,
            },
        },
    },
}

return mission
