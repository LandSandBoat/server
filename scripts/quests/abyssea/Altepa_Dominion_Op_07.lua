-----------------------------------
-- Altepa - Dominion Op #07
-----------------------------------
-- !addquest 8 93
-- Dominion Sergeant (Excenmille's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_07_ALTEPA)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ALTEPA] =
        {
            ['Desert_Puk'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 566)
                end,
            },
        },
    },
}

return quest
