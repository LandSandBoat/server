-----------------------------------
-- Trust: Semih
-----------------------------------

local quest = HiddenQuest:new('TrustSemih')

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return not player:hasSpell(xi.magic.spell.SEMIH_LAFIHNA) and
                not player:findItem(xi.item.CIPHER_OF_SEMIHS_ALTER_EGO) and
                player:hasCompletedMission(xi.mission.log_id.ROV, xi.mission.id.rov.THE_PATH_UNTRAVELED)
        end,

        [xi.zone.HEAVENS_TOWER] =
        {
            ['Kupipi'] =
            {
                onTrigger = function(player, npc)
                    -- NOTE: No cap has been provided to determine if there is separate dialogue.  This
                    -- exists as a stopgap to ensure that the player can receive the item in case of full
                    -- inventory, or having already progressed.

                    npcUtil.giveItem(player, xi.item.CIPHER_OF_SEMIHS_ALTER_EGO)
                    return quest:noAction()
                end,
            },
        },
    },
}

return quest
