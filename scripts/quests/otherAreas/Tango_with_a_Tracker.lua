-----------------------------------
-- Tango With a Tracker
-----------------------------------
-- Log ID: 4, Quest ID: 82
-- Despachiaire
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER)

-- Quest completion is handled by battlefield

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasKeyItem(xi.ki.TEAR_OF_ALTANA)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(576),

            onEventFinish =
            {
                [576] = function(player, csid, option, npc)
                        npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_X)
                        quest:begin(player)
                end,
            },
        }
    },

    {
        -- If player loses battlefield, they must return to Despachiaire for another KI
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            not player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_X)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(576),

            onEventFinish =
            {
                [576] = function(player, csid, option, npc)
                        npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_X)
                end,
            },
        }
    },
}

return quest
