-----------------------------------
-- Altepa - Dominion Op #06
-----------------------------------
-- !addquest 8 92
-- Dominion Sergeant (Volker's Camp)
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_06_ALTEPA)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ALTEPA] =
        {
            ['Camelopardalis'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 565)
                end,
            },
        },
    },
}

return quest
