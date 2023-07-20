-----------------------------------
-- Trust: Zeid II
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/hidden_quest')
-----------------------------------

local quest = HiddenQuest:new("TrustZeidII")

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return not player:hasSpell(xi.magic.spell.ZEID_II) and
                not player:findItem(xi.items.CIPHER_OF_ZEIDS_ALTER_EGO_II) and
                player:hasCompletedMission(xi.mission.log_id.ROV, xi.mission.id.rov.VOLTO_OSCURO)
        end,

        [xi.zone.NORG] =
        {
            ['_700'] =
            {
                onTrigger = function(player, npc)
                    -- NOTE: No cap has been provided to determine if there is separate dialogue.  This
                    -- exists as a stopgap to ensure that the player can receive the item in case of full
                    -- inventory, or having already progressed.

                    npcUtil.giveItem(player, xi.items.CIPHER_OF_ZEIDS_ALTER_EGO_II)
                    return quest:noAction()
                end,
            },
        },
    },
}

return quest
