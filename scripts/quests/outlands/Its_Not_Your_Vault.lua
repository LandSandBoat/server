-----------------------------------
-- It's Not Your Vault
-- https://wiki.ffo.jp/html/12512.html
-----------------------------------
-- Log ID: 5, Quest ID: 137
-- Keal : !pos -5.453 0.151 -16.361 252
-- qm3  : !pos -173.671 26.951 252.009 176
-----------------------------------
local seaSerpentID = zones[xi.zone.SEA_SERPENT_GROTTO]
-----------------------------------

local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.ITS_NOT_YOUR_VAULT)

quest.reward =
{
    fame     = 30,
    fameArea = xi.fameArea.NORG,
    item     = xi.item.SCROLL_OF_TONKO_ICHI,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.NORG) >= 3 and
                player:getMainLvl() >= 5
        end,

        [xi.zone.NORG] =
        {
            ['Keal'] =
            {
                onTrigger = function(player, npc)
                    local hasDeclined = quest:getVar(player, 'Option')

                    return quest:progressEvent(36, { [0] = xi.keyItem.SEALED_IRON_BOX, [7] = hasDeclined })
                end,
            },

            onEventFinish =
            {
                [36] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    else
                        quest:setVar(player, 'Option', 1)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.NORG] =
        {
            ['Keal'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.keyItem.SEALED_IRON_BOX) then
                        return quest:progressEvent(38)
                    else
                        return quest:event(37, xi.keyItem.MAP_OF_SEA_SERPENT_GROTTO)
                    end
                end,
            },

            onEventFinish =
            {
                [38] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.keyItem.SEALED_IRON_BOX)
                    end
                end,
            },
        },

        [xi.zone.SEA_SERPENT_GROTTO] =
        {
            ['qm3'] =
            {
                onTrigger = function(player, npc)
                    if not player:hasKeyItem(xi.keyItem.SEALED_IRON_BOX) then
                        return quest:keyItem(xi.keyItem.SEALED_IRON_BOX)
                    end

                    player:messageText(npc, seaSerpentID.text.NO_LONGER_ANYTHING_ON_FLOOR, false, 6)
                    return quest:noAction()
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.NORG] =
        {
            ['Keal'] = quest:event(39):replaceDefault(),
        },
    },
}

return quest
