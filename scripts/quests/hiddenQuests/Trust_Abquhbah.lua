-----------------------------------
-- Trust: Abquhbah
-----------------------------------

local quest = HiddenQuest:new('TrustAbquhbah')

quest.sections =
{
    {
        check = function(player, questVars, vars)
            return not player:hasSpell(xi.magic.spell.ABQUHBAH) and
                not player:findItem(xi.item.CIPHER_OF_ABQUHBAHS_ALTER_EGO) and
                player:hasCompletedMission(xi.mission.log_id.TOAU, xi.mission.id.toau.IMMORTAL_SENTRIES) and
                player:getCurrentMission(xi.mission.log_id.ROV) >= xi.mission.id.rov.EVER_FORWARD
        end,

        [xi.zone.AHT_URHGAN_WHITEGATE] =
        {
            ['Abquhbah'] =
            {
                onTrigger = function(player, npc)
                    local hasTrustPermit = xi.trust.hasPermit(player) and 1 or 0

                    return quest:progressEvent(170, { [1] = hasTrustPermit, [2] = player:getNation(), text_table = 0 })
                end,
            },

            onEventFinish =
            {
                [170] = function(player, csid, option, npc)
                    if xi.trust.hasPermit(player) then
                        npcUtil.giveItem(player, xi.item.CIPHER_OF_ABQUHBAHS_ALTER_EGO)
                    end
                end,
            },
        },
    },
}

return quest
