-----------------------------------
-- Watery Grave
-- Seekers of Adoulin M5-3-2
-----------------------------------
-- !addmission 12 118
-----------------------------------
require('scripts/globals/missions')
require('scripts/globals/interaction/mission')
require('scripts/globals/zone')
-----------------------------------
local ralaID = require('scripts/zones/Rala_Waterways/IDs')
-----------------------------------

local mission = Mission:new(xi.mission.log_id.SOA, xi.mission.id.soa.WATERY_GRAVE)

mission.reward =
{
    nextMission = { xi.mission.log_id.SOA, xi.mission.id.soa.BLOOD_FOR_BLOOD },
}

mission.sections =
{
    {
        check = function(player, currentMission, missionStatus, vars)
            return currentMission == mission.missionId
        end,

        [xi.zone.RALA_WATERWAYS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    if mission:getVar(player, 'Status') == 1 then
                        return 375
                    end
                end,
            },

            afterZoneIn =
            {
                function(player)
                    if
                        not player:hasKeyItem(xi.ki.ASH_RUNIC_BOARD) and
                        mission:getVar(player, 'Status') == 0 and
                        mission:getVar(player, 'Timer') <= VanadielUniqueDay()
                    then
                        -- TODO: This message needs verification, and need to determine if there
                        -- is a unique event or message.  For future Instance implementation, on
                        -- instance fail, Timer var should be set to VanadielUniqueDay() + 1
                        player:delKeyItem(xi.ki.BLANK_ASH_RUNIC_BOARD)
                        npcUtil.giveKeyItem(player, xi.ki.ASH_RUNIC_BOARD)
                    end
                end,
            },

            onEventFinish =
            {
                [375] = function(player, csid, option, npc)
                    if mission:complete(player) then
                        player:delKeyItem(xi.ki.BLANK_ASH_RUNIC_BOARD)
                        player:messageSpecial(ralaID.text.KEYITEM_LOST, xi.ki.BLANK_ASH_RUNIC_BOARD)
                        npcUtil.giveKeyItem(player, xi.ki.AGED_UNDYING_NAAKUAL_CREST)
                        npcUtil.giveKeyItem(player, xi.ki.TEODORS_BLOOD_SIGIL)
                        player:messageSpecial(ralaID.text.THREE_BLOOD_SIGILS_PULSE)
                        npcUtil.giveKeyItem(player, xi.ki.CRYSTALLIZED_PSYCHE)
                    end
                end,
            },
        },

        [xi.zone.RALA_WATERWAYS_U] =
        {
            onEventFinish =
            {
                -- TODO: The assumption for this mission script is to catch Event 1000 which is
                -- sent once the battlefield has been cleared.  This needs to be verified upon
                -- implementation of the instance.
                [1000] = function(player, csid, option, npc)
                    mission:setVar(player, 'Status', 1)
                    player:setPos(256, -5.768, 60, 128, xi.zone.RALA_WATERWAYS)
                end,
            },
        },
    },
}

return mission
