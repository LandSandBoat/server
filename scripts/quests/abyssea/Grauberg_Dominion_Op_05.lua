-----------------------------------
-- Grauberg - Dominion Op #05
-----------------------------------
-- !addquest 8 119
-- Dominion Sergeant : !pos -15.513 0.64 -482.04 254
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_05_GRAUBERG)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_GRAUBERG] =
        {
            ['Putrid_Peapuk'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 592)
                end,
            },
        },
    },
}

return quest
