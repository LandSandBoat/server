-----------------------------------
-- Beneath a Blood Red Sky
-----------------------------------
-- !addquest 8 183
-- Transcendental Radiance : !pos -259.433 -21.581 220.498 126
-- Flagged on completion of Emissaries of God.
-- Zone into Abyssea - Empyreal Paradox. Flag The Wyrm God upon completion.
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.BENEATH_A_BLOOD_RED_SKY)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_EMPYREAL_PARADOX] =
        {
            onZoneIn = function(player, prevZone)
                return 202
            end,

            onEventFinish =
            {
                [202] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:addQuest(xi.questLog.ABYSSEA, xi.quest.id.abyssea.THE_WYRM_GOD)
                    end
                end,
            },
        },
    },
}

return quest
