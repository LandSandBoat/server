-----------------------------------
-- Altepa - Dominion Op #05
-----------------------------------
-- !addquest 8 91
-- Dominion Sergeant (Volker's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_05_ALTEPA)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ALTEPA] =
        {
            ['Manigordo'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 564)
                end,
            },
        },
    },
}

return quest
