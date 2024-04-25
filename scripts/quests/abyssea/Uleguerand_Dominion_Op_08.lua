-----------------------------------
-- Uleguerand - Dominion Op #08
-----------------------------------
-- !addquest 8 108
-- Dominion Sergeant (Maat's Camp)
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_08_ULEGUERAND)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_ULEGUERAND] =
        {
            ['Adasaurus'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 581)
                end,
            },
        },
    },
}

return quest
