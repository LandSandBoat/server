-----------------------------------
-- Altepa - Dominion Op #09
-----------------------------------
-- !addquest 8 95
-- Dominion Sergeant (Excenmille's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_09_ALTEPA)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ALTEPA] =
        {
            ['Dune_Cockatrice'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 568)
                end,
            },
        },
    },
}

return quest
