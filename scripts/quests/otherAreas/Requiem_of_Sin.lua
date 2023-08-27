-----------------------------------
-- Requiem of Sin
-----------------------------------
-- Log ID: 4, Quest ID: 83
-- Despachiaire
-- Notes:
--   Players can receive key item, wait a conquest tally, and do this quest immmediately again
--   Moreover players can receive an unlimited amount of key items until they win the battlefield.
--   This is handled upon loss of the battlefield. "CONQUEST_REQUIEM_OF_SIN" if reset to 0 if they lose.
--   Quest is complete upon winning the battlefield.
-----------------------------------
require('scripts/globals/npc_util')
require('scripts/globals/quests')
require('scripts/globals/titles')
require('scripts/globals/zone')
require('scripts/globals/interaction/quest')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.REQUIEM_OF_SIN)

-- Quest completion is handled by battlefield

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_AVAILABLE and
            player:hasCompletedQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.TANGO_WITH_A_TRACKER) and
            quest:getVar(player, 'conquestRequiem') <= os.time() and
            quest:getVar(player, 'conquestRequiem') > 0 -- Prevents players from getting this quest too early.
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(579),

            onEventFinish =
            {
                [579] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_Y)
                    quest:setVar(player, 'conquestRequiem', getConquestTally())
                    quest:begin(player)
                end,
            },
        }
    },

    {
        -- If player loses battlefield, they must return to Despachiaire for another KI
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED and
            not player:hasKeyItem(xi.ki.LETTER_FROM_SHIKAREE_Y)
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(579),

            onEventFinish =
            {
                [579] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_SHIKAREE_Y)
                    quest:setVar(player, 'conquestRequiem', getConquestTally())
                end,
            },
        }
    },

    {
        check = function(player, status, vars)
            return status == QUEST_COMPLETED and
            not player:hasKeyItem(xi.ki.LETTER_FROM_THE_MITHRAN_TRACKERS) and
            quest:getVar(player, 'conquestRequiem') <= os.time()
        end,

        [xi.zone.TAVNAZIAN_SAFEHOLD] =
        {
            ['Despachiaire'] = quest:progressEvent(579),

            onEventFinish =
            {
                [579] = function(player, csid, option, npc)
                    -- "CONQUEST_REQUIEM" is reset if players lose battlefield
                    quest:setVar(player, 'conquestRequiem', getConquestTally())
                    npcUtil.giveKeyItem(player, xi.ki.LETTER_FROM_THE_MITHRAN_TRACKERS)
                end,
            },
        }
    },
}

return quest
