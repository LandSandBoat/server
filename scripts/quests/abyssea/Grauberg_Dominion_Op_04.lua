-----------------------------------
-- Grauberg - Dominion Op #04
-----------------------------------
-- !addquest 8 118
-- Dominion Sergeant : !pos -15.513 0.64 -482.04 254
-----------------------------------

local quest = Quest:new(xi.questLog.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_04_GRAUBERG)

quest.reward = {}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.ABYSSEA_GRAUBERG] =
        {
            ['Faunus_Wyvern'] =
            {
                onMobDeath = function(mob, player, optParams)
                    xi.abyssea.dominionOnMobDeath(mob, player, 591)
                end,
            },
        },
    },
}

return quest
