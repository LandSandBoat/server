-----------------------------------
-- Moon Reading
-- Windurst M9-2
-----------------------------------
-- !addmission 2 23
-- Rakoh Buuma      : !pos 106 -5 -23 241
-- Mokyokyo         : !pos -55 -8 227 238
-- Janshura-Rashura : !pos -227 -8 184 240
-- Zokima-Rokima    : !pos 0 -16 124 239
-- _6q2             : !pos 0.1 -49 37 242
-- qm16             : !pos -239.442 -1.000 -18.870 159
-- Qu'Hau Spring    : !pos 0 -29 64 122
require('scripts/globals/interaction/mission')
require('scripts/globals/items')
require('scripts/globals/missions')
require('scripts/globals/npc_util')
require('scripts/globals/zone')
-----------------------------------
local heavensTowerID = require("scripts/zones/Heavens_Tower/IDs")
-----------------------------------

local mission = Mission:new(xi.mission.log_id.WINDURST, xi.mission.id.windurst.MOON_READING)

mission.reward =
{
    gil   = 100000,
    item  = xi.items.WINDURSTIAN_FLAG,
    rank  = 10,
    title = xi.title.VESTAL_CHAMBERLAIN,
}

local handleAcceptMission = function(player, csid, option, npc)
    if option == 23 then
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

        [xi.zone.PORT_WINDURST] =
        {
            onEventFinish =
            {
                [78] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onEventFinish =
            {
                [93] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WATERS] =
        {
            onEventFinish =
            {
                [111] = handleAcceptMission,
            },
        },

        [xi.zone.WINDURST_WOODS] =
        {
            onEventFinish =
            {
                [114] = handleAcceptMission,
            },
        },
    },

    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.CHAMBER_OF_ORACLES] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if
                        prevZone == xi.zone.QUICKSAND_CAVES and
                        player:getMissionStatus(mission.areaId) >= 1
                    then
                        return 3
                    end
                end,
            },

            onEventFinish =
            {
                [3] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ANCIENT_VERSE_OF_ALTEPA)
                end,
            },
        },

        [xi.zone.FULL_MOON_FOUNTAIN] =
        {
            onEventFinish =
            {
                [32001] = function(player, csid, option, npc)
                    if
                        player:getMissionStatus(mission.areaId) == 2 and
                        player:getLocalVar('battlefieldWin') == 225
                    then
                        player:setMissionStatus(mission.areaId, 3)
                    end
                end,
            },
        },

        [xi.zone.HEAVENS_TOWER] =
        {
            ['_6q2'] =
            {
                onTrigger = function(player, npc)
                    local missionStatus = player:getMissionStatus(mission.areaId)

                    if missionStatus == 0 then
                        return mission:progressEvent(384)
                    elseif
                        missionStatus == 1 and
                        player:hasKeyItem(xi.ki.ANCIENT_VERSE_OF_ROMAEVE) and
                        player:hasKeyItem(xi.ki.ANCIENT_VERSE_OF_ALTEPA) and
                        player:hasKeyItem(xi.ki.ANCIENT_VERSE_OF_UGGALEPIH)
                    then
                        return mission:progressEvent(385)
                    elseif missionStatus == 3 then
                        return mission:progressEvent(386, 0, 0, xi.ki.ORASTERY_RING)
                    elseif missionStatus == 4 then
                        -- This does not use the npcUtil function, as in both cases we need to return
                        -- an appropriate mission function.

                        if player:getFreeSlotsCount() == 0 then
                            return mission:messageSpecial(heavensTowerID.text.ITEM_CANNOT_BE_OBTAINED, xi.items.WINDURSTIAN_FLAG)
                        else
                            return mission:progressEvent(407)
                        end
                    end
                end,
            },

            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) >= 3 then
                        return mission:progressEvent(400):importantOnce()
                    end
                end,
            },

            onEventFinish =
            {
                [384] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 1)
                end,

                [385] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 2)
                end,

                [386] = function(player, csid, option, npc)
                    player:setMissionStatus(mission.areaId, 4)
                end,

                [407] = function(player, csid, option, npc)
                    player:setPos(0, -16.750, 130, 64, 239)
                end,
            },
        },

        [xi.zone.ROMAEVE] =
        {
            ['QuHau_Spring'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) >= 1 then
                        return mission:progressEvent(4)
                    end
                end,
            },

            onEventFinish =
            {
                [4] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ANCIENT_VERSE_OF_ROMAEVE)
                end,
            },
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['qm16'] =
            {
                onTrigger = function(player, npc)
                    if player:getMissionStatus(mission.areaId) >= 1 then
                        return mission:progressEvent(68)
                    end
                end,
            },

            onEventFinish =
            {
                [68] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.ANCIENT_VERSE_OF_UGGALEPIH)
                end,
            },
        },

        [xi.zone.WINDURST_WALLS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if player:getMissionStatus(mission.areaId) == 4 then
                        return 443
                    end
                end,
            },

            onEventFinish =
            {
                [443] = function(player, csid, option, npc)
                    -- NOTE: Inventory is checked before this series of events.  This is not
                    -- correct behavior, and instead if unable to obtain, it can be obtained
                    -- by clicking the blank target in Heaven's Tower
                    -- See: https://ffxiclopedia.fandom.com/wiki/Moon_Reading

                    mission:complete(player)
                end,
            },
        },
    },

    -- Optional Dialogue
    {
        check = function(player, currentMission, missionStatus, vars)
            return (currentMission == mission.missionId and missionStatus >= 3) or
                player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            -- NOTE: The replaceDefault behavior is current function from the scripts.  This
            -- may be inconsistent with how San d'Oria optional dialogue is handled, and should
            -- be verified.  It appears that in a previous iteration, there were unique charVars
            -- tracking these.  These might just be a 'Once' event, but can be adapted here if
            -- necessary by adding a bitfield to a check, and tabling up the bit values along
            -- with a helper function.

            ['Aeshushu']       = mission:event(391):replaceDefault(),
            ['Boycoco']        = mission:event(388):replaceDefault(),
            ['Churara']        = mission:event(390):replaceDefault(),
            ['Dattata']        = mission:event(392):replaceDefault(),
            ['Foo_Beibo']      = mission:event(403):replaceDefault(),
            ['Heruru']         = mission:event(393):replaceDefault(),
            ['Ikucheechee']    = mission:event(394):replaceDefault(),
            ['Kinono']         = mission:event(398):replaceDefault(),
            ['Kiwawa']         = mission:event(389):replaceDefault(),
            ['Nayutata']       = mission:event(395):replaceDefault(),
            ['Nebibi']         = mission:event(399):replaceDefault(),
            ['Rhy_Epocan']     = mission:event(405):replaceDefault(),
            ['Shaz_Norem']     = mission:event(401):replaceDefault(),
            ['Tsuryarya']      = mission:event(396):replaceDefault(),
            ['Ufu_Koromoa']    = mission:event(402):replaceDefault(),
            ['Utsuitsui']      = mission:event(397):replaceDefault(),
            ['Vahn_Paineesha'] = mission:event(404):replaceDefault(),
            ['Zubaba']         = mission:event(387):replaceDefault(),
        },
    },

    -- Optional Dialogue on Completed Mission Only.  This should be verified to confirm that
    -- these events are actually played more than once, and also check to see if they are blocking
    -- for running future repeatable missions.
    -- TODO: Capture events for missing gate guards.
    {
        check = function(player, currentMission, missionStatus, vars)
            return player:hasCompletedMission(mission.areaId, mission.missionId)
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Janshura_Rashura'] = mission:event(567):oncePerZone(),
        },

        [xi.zone.WINDURST_WATERS] =
        {
            ['Mokyoko']       = mission:event(837):oncePerZone(),
            ['Tosuka-Porika'] = mission:event(380):replaceDefault(),
        },

        [xi.zone.WINDURST_WOODS] =
        {
            ['Rakoh_Buuma'] = mission:event(632):oncePerZone(),
        },
    },
}

return mission
