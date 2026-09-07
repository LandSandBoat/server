-----------------------------------
-- Tenshodo Membership
-----------------------------------
-- Log ID: 3, Quest ID: 17
-- NPC: Ghebi Damomohe !pos 16 -.1 -5.2 245
-- NPC: Jabbar !pos -101 -2.3 23 236
-- NOTE: Players can straight turn in Tenshodo Invite bypassing this quest. Quest never shows in log until completed.
-----------------------------------

local quest = Quest:new(xi.questLog.JEUNO, xi.quest.id.jeuno.TENSHODO_MEMBERSHIP)

quest.reward =
{
    item    = xi.item.TENSHODO_INVITE,
    keyItem = xi.ki.TENSHODO_MEMBERS_CARD,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.JEUNO) >= 3
        end,

        [xi.zone.LOWER_JEUNO] =
        {
            ['Ghebi_Damomohe'] =
            {
                onTrade = function(player, npc, trade)
                    if npcUtil.tradeHasExactly(trade, { xi.item.TENSHODO_INVITE }) then
                        return quest:progressEvent(108)
                    end
                end,

                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.keyItem.TENSHODO_APPLICATION_FORM) then
                        return quest:progressEvent(107)
                    elseif
                        player:hasKeyItem(xi.ki.PSOXJA_PASS) and
                        not player:hasKeyItem(xi.ki.ASTRAL_COVENANT)
                    then
                        local astralCovenantCD = player:getCharVar('[ENM]AstralCovenant')
                        if astralCovenantCD < VanadielTime() then
                            -- Tells player about Florid Stone, with hidden option from quest
                            return quest:event(106, 0, 1, xi.item.FLORID_STONE, xi.ki.PSOXJA_PASS, xi.ki.ASTRAL_COVENANT)
                        else
                            -- Tells player they are on cooldown, with hidden option from quest
                            return quest:event(106, 0, 2, xi.ki.ASTRAL_COVENANT, astralCovenantCD)
                        end
                    else
                        return quest:event(106)
                    end
                end,
            },

            onEventFinish =
            {
                [106] = function(player, csid, option, npc)
                    if option == 2 then
                        quest:setVar(player, 'Prog', 1)
                    end
                end,

                [107] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.keyItem.TENSHODO_APPLICATION_FORM)
                    end
                end,

                [108] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:tradeComplete()
                        player:delKeyItem(xi.keyItem.TENSHODO_APPLICATION_FORM)
                    end
                end,
            },
        },

        [xi.zone.PORT_BASTOK] =
        {
            ['Jabbar'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TENSHODO_APPLICATION_FORM) then
                        return quest:progressEvent(152)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(151)
                    end
                end,
            },

            ['Silver_Owl'] =
            {
                onTrigger = function(player, npc)
                    if player:hasKeyItem(xi.ki.TENSHODO_APPLICATION_FORM) then
                        return quest:progressEvent(152, 1)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(151, 1)
                    end
                end,
            },

            onEventFinish =
            {
                [151] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.keyItem.TENSHODO_APPLICATION_FORM)
                end,
            },
        },
    }
}

return quest
