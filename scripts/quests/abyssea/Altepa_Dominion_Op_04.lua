-----------------------------------
-- Altepa - Dominion Op #04
-----------------------------------
-- !addquest 8 90
-- Dominion Sergeant (Volker's Camp)
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_04_ALTEPA)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ALTEPA] =
        {
            ['Dune_Manticore'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 563)
                end,
            },
        },
    },
}

return quest
