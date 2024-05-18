-----------------------------------
-- Better the Demon you Know
-----------------------------------
-- Log ID: 4, Quest ID: 105
-- Koblakiq          !pos -64 21 -117 11
-- qm_demon_you_know !pos 20 -24 15 161
-----------------------------------
local castleZvahlBaileysID = zones[xi.zone.CASTLE_ZVAHL_BAILEYS]
-----------------------------------
local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.BETTER_THE_DEMON_YOU_KNOW)

quest.reward =
{
    item = xi.item.GOBLIN_GRENADE,
    title = xi.title.APOSTATE_FOR_HIRE
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.FOR_THE_BIRDS) and
                not quest:getMustZone(player)
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:progressEvent(20, { [1] = xi.item.DEMON_PEN }),

            onEventFinish =
            {
                [20] = function(player, csid, option, npc)
                    quest:begin(player)
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_ACCEPTED
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] =
            {
                onTrigger = function(player, npc)
                    local prog = quest:getVar(player, 'Prog')

                    if prog == 0 then
                        return quest:progressEvent(21, { [1] = xi.item.DEMON_PEN }) -- Additional Dialogue
                    elseif quest:getVar(player, 'Wait') > os.time() then
                        return quest:progressEvent(23)
                    elseif
                        prog == 1 and
                        quest:getVar(player, 'Wait') < os.time()
                    then
                        return quest:progressEvent(24)
                    elseif prog == 2 then
                        return quest:progressEvent(25)
                    elseif player:hasKeyItem(xi.ki.ZEELOZOKS_EARPLUG) then
                        return quest:progressEvent(26)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.tradeHasExactly(trade, { xi.item.DEMON_PEN })
                    then
                        return quest:progressEvent(22)
                    end
                end,
            },

            onEventFinish =
            {
                [22] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Wait', os.time() + 60) -- midnight for era, 1 min for retail
                    quest:setVar(player, 'Prog', 1)
                end,

                [24] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [26] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        player:delKeyItem(xi.ki.ZEELOZOKS_EARPLUG)
                    end
                end,
            },
        },

        [xi.zone.CASTLE_ZVAHL_BAILEYS] =
        {
            ['qm_demon_you_know'] =
            {
                onTrigger = function(player, npc)
                    local mobs =
                    {
                        castleZvahlBaileysID.mob.DEMON_YOU_KNOW_OFFSET,
                        castleZvahlBaileysID.mob.DEMON_YOU_KNOW_OFFSET + 1,
                        castleZvahlBaileysID.mob.DEMON_YOU_KNOW_OFFSET + 2,
                        castleZvahlBaileysID.mob.DEMON_YOU_KNOW_OFFSET + 3,
                        castleZvahlBaileysID.mob.DEMON_YOU_KNOW_OFFSET + 4,
                    }

                    if
                        quest:getVar(player, 'Prog') == 2 and
                        npcUtil.popFromQM(player, npc, mobs, { claim = true, hide = 0, })
                    then
                        player:messageSpecial(castleZvahlBaileysID.text.MOBLIN_EARPLUG)
                        return quest:message(castleZvahlBaileysID.text.MINIONS_ATTACK)

                    elseif
                        quest:getVar(player, 'Prog') == 3 and
                        not player:hasKeyItem(xi.ki.ZEELOZOKS_EARPLUG)
                    then
                        player:addKeyItem(xi.ki.ZEELOZOKS_EARPLUG)
                        return quest:messageSpecial(castleZvahlBaileysID.text.KEYITEM_OBTAINED, xi.ki.ZEELOZOKS_EARPLUG)
                    end
                end,
            },

            ['Marquis_Andrealphus'] =
            {
                onMobDeath = function(mob, player, isKiller, firstCall)
                    if quest:getVar(player, 'Prog') == 2 then
                        quest:setVar(player, 'Prog', 3)
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_COMPLETED
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:event(27):replaceDefault(),
        },
    },
}

return quest
