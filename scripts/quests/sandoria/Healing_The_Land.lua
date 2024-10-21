-----------------------------------
-- Healing the Land
-----------------------------------
-- !addquest 0 82
-- Eperdur: !pos 129 -6 96 231
-- qm3: !pos -168 1 311 196
-----------------------------------
local gugsenMinesID = zones[xi.zone.GUSGEN_MINES]
-----------------------------------
---@type TQuest
local quest = Quest:new(xi.questLog.SANDORIA, xi.quest.id.sandoria.HEALING_THE_LAND)

quest.reward =
{
    fame = 30,
    fameArea = xi.fameArea.SANDORIA,
    item = xi.item.SCROLL_OF_TELEPORT_HOLLA,
    title = xi.title.PILGRIM_TO_HOLLA,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.SANDORIA) >= 4 and
                player:getMainLvl() >= 10
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Eperdur'] = quest:progressEvent(681),

            onEventFinish =
            {
                [681] = function(player, csid, option, npc)
                    quest:begin(player)
                    npcUtil.giveKeyItem(player, xi.ki.SEAL_OF_BANISHING)
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Eperdur'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SEAL_OF_BANISHING) then
                        return quest:event(682)
                    else
                        return quest:progressEvent(683)
                    end
                end,
            },

            onEventFinish =
            {
                [683] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setMustZone(player, xi.questLog.SANDORIA, xi.quest.id.sandoria.SORCERY_OF_THE_NORTH)
                    end
                end,
            },
        },

        [xi.zone.GUSGEN_MINES] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.SEAL_OF_BANISHING) then
                        player:delKeyItem(xi.ki.SEAL_OF_BANISHING)
                        return quest:messageSpecial(gugsenMinesID.text.FOUND_LOCATION_SEAL, xi.ki.SEAL_OF_BANISHING)
                    else
                        player:messageSpecial(gugsenMinesID.text.IS_ON_THIS_SEAL, xi.ki.SEAL_OF_BANISHING)
                        return quest:noAction()
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.NORTHERN_SAN_DORIA] =
        {
            ['Eperdur'] = quest:event(684):replaceDefault(),
        },
    },
}

return quest
