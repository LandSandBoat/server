-----------------------------------
-- You Call That a Knife
-----------------------------------
-- Log ID: 5, Quest ID: 6
-- Mhebi Juhbily : !pos 40 -11 -159 250
-- Vah Keshura   : !pos 30 -8.5 -105 250
-- Chef Nonberry : !pos -136 0.0 -91 159
-- Pula Rhatti   : !pos -18.5 -4 -38 250
-----------------------------------
local templeID = zones[xi.zone.TEMPLE_OF_UGGALEPIH]
-----------------------------------

---@type TQuest
local quest = Quest:new(xi.questLog.OUTLANDS, xi.quest.id.outlands.YOU_CALL_THAT_A_KNIFE)

quest.reward =
{
    fame     = 75,
    fameArea = xi.fameArea.WINDURST,
    gil      = 7200,
    title    = xi.title.YA_DONE_GOOD
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 6
        end,

        [xi.zone.KAZHAM] =
        {
            ['Mhebi_Juhbily'] =
            {
                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.tradeHasExactly(trade, { xi.item.SANDFISH })
                    then
                        return quest:progressEvent(127, 0, xi.item.SANDFISH)
                    end
                end,

                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:event(318)
                    end
                end
            },

            ['Pula_Rhatti'] = quest:event(269, 0, xi.item.SANDFISH),

            ['_6y9'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(128)
                    end
                end
            },

            onEventFinish =
            {
                [127] = function(player, csid, option, npc)
                    if option == 511 then
                        quest:setVar(player, 'Prog', 1)
                        player:confirmTrade()
                    end
                end,

                [128] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                not player:hasKeyItem(xi.ki.NONBERRYS_KNIFE)
        end,

        [xi.zone.KAZHAM] =
        {
            ['Mhebi_Juhbily'] = quest:event(129),

            ['Pula_Rhatti'] = quest:event(269, 0, xi.item.SANDFISH),

            ['Vah_Keshura'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(130)
                    else
                        return quest:event(131)
                    end
                end,
            },

            onEventFinish =
            {
                [130] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end
            },
        },

        [xi.zone.TEMPLE_OF_UGGALEPIH] =
        {
            ['Chef_Nonberry'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.TONBERRY_BOARD }) then
                        return quest:progressEvent(27)
                    else
                        return quest:progressEvent(28)
                    end
                end,
            },

            onEventFinish =
            {
                [27] = function(player, csid, option, npc)
                    player:confirmTrade()
                    npcUtil.giveKeyItem(player, xi.ki.NONBERRYS_KNIFE)
                end,

                [28] = function(player, csid, option, npc)
                    player:tradeComplete()
                    local cookMobs = {
                        templeID.mob.COOK_OFFSET,
                        templeID.mob.COOK_OFFSET + 1,
                        templeID.mob.COOK_OFFSET + 2,
                        templeID.mob.COOK_OFFSET + 3
                    }
                    if
                        os.time() >= npc:getLocalVar('cooldown') and
                        npcUtil.popFromQM(player, npc, cookMobs, { claim = true, hide = 0 })
                    then
                        npc:setLocalVar('cooldown', os.time() + 600) -- 10 minutes between repops
                    end
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED and
                player:hasKeyItem(xi.ki.NONBERRYS_KNIFE)
        end,

        [xi.zone.KAZHAM] =
        {
            ['Mhebi_Juhbily'] = quest:progressEvent(133),

            ['Vah_Keshura'] =  quest:event(132),

            onEventFinish =
            {
                [133] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.NONBERRYS_KNIFE)
                        quest:setMustZone(player)
                    end
                end
            },
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                quest:getMustZone(player)
        end,

        [xi.zone.KAZHAM] =
        {
            ['Mhebi_Juhbily'] = quest:event(134),
        },
    },

    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED and
                not quest:getMustZone(player)
        end,

        [xi.zone.KAZHAM] =
        {
            ['Mhebi_Juhbily'] = quest:event(135),
        },
    },
}

return quest
