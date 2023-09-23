-----------------------------------
-- A Generous General
-- Oldton south eastern zone line !zone north gusta !pos 566 -12 685
-- Faulpie !pos -179.88 -1.0 10.16
-- iron box !pos -140.95 7.51 157.20
-----------------------------------
require('scripts/globals/quests')
require('scripts/globals/interaction/quest')
require('scripts/globals/npc_util')
-----------------------------------
local oldton = require('scripts/zones/Oldton_Movalpolos/IDs')
-----------------------------------
local quest = Quest:new(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_GENEROUS_GENERAL)

local spawnedMobs =
{
    oldton.mob.GOBLIN_PRECEPTOR,
    oldton.mob.GRIMOIRE_GURU_GRIMOGEK,
    oldton.mob.DREAD_DEALING_DREDODAK,
    oldton.mob.BUGBEAR_PORTERMAN1,
    oldton.mob.BUGBEAR_PORTERMAN2,
    oldton.mob.BUGBEAR_PORTERMAN3,
    oldton.mob.BUGBEAR_PORTERMAN4,
}

quest.reward =
{
    item  = xi.items.GOLD_BEASTCOIN,
    title = xi.title.MOBLIN_KINSMAN,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.AN_AFFABLE_ADAMANTKING) ~= QUEST_ACCEPTED and
            player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.AN_UNDERSTANDING_OVERLORD) ~= QUEST_ACCEPTED and
            player:getQuestStatus(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_MORAL_MANIFEST) ~= QUEST_ACCEPTED and
            player:getVar("BstHeadGearQuest_Conquest") < getConquestTally() and
            not player:hasItem(xi.items.CHOPLIXS_COIF) and
            player:getMainLvl() >= 60

        -- this and other bstmn hat quests, are repeatable every conquest tally (i.e. 1 per tally). this will be a permanent var that gets reset every time the quest is redone.
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
            {
            onZoneIn =
            {
                function(player, prevZone)
                    local pos = player:getPos()
                    if
                        pos.x >= -323.0 and
                        pos.y >= 6.0 and
                        pos.z >= -261.0 and
                        pos.x <= -321.0 and
                        pos.y <= 9.0 and
                        pos.z <= -258.0 and
                        quest:getVar(player, 'Prog') == 0
                    then
                        return 60
                    end
                end,
            },

            onEventFinish =
            {
                [60] = function(player, csid, option, npc)
                    if option == 0 then
                        quest:begin(player)
                        player:setVar("BstHeadgearQuest", 1)
                    elseif option == 1 then
                        player:setVar("BstHeadGearQuest_Conquest", getConquestTally()) -- if you decline, you can't start until next tally
                    end
                end,
            },
        },
    },
    {
        check = function(player, status, vars)
            return status == QUEST_ACCEPTED
        end,

        [xi.zone.SOUTHERN_SAN_DORIA] =
        {
            ['Faulpie'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:progressEvent(770)
                    elseif quest:getVar(player, 'Prog') == 1 then
                        return quest:progressEvent(771)
                    elseif quest:getVar(player, 'Prog') == 2 then
                        if os.time() > quest:getVar(player, 'Option') then
                            return quest:progressEvent(775)
                        else
                            return quest:event(773)
                        end
                    elseif
                        quest:getVar(player, 'Prog') == 3 and
                        not player:hasItem(xi.items.GOBLIN_COIF_CUTTING) and
                        not quest:getMustZone(player)
                    then
                        return quest:progressEvent(774)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { xi.items.BUFFALO_HIDE, xi.items.SQUARE_OF_SHEEP_LEATHER, { "gil", 10000 } }) and
                        quest:getVar(player, 'Prog') == 1
                    then
                        return quest:progressEvent(772)
                    end
                end,
            },

            onEventFinish =
            {
                [770] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                end,

                [771] = function(player, csid, option, npc)
                    if option == 100 then
                        -- note: you are able to reobtain the quest after cancelling, without a conquest wait
                        player:messageSpecial(zones[player:getZoneID()].text.QUEST_CANCELLED)
                        quest:setVar(player, 'Prog', 0)
                        quest:setVar(player, 'Option', 0)
                        player:setVar("BstHeadGearQuest_Conquest", 0)
                        player:setVar("BstHeadgearQuest", 0)
                        player:delQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_GENEROUS_GENERAL)
                    end
                end,

                [772] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 2)
                    quest:setVar(player, 'Option', getVanaMidnight())
                end,

                [774] = function(player, csid, option, npc)
                    if option == 0 and player:getGil() >= 100000 then
                        player:delGil(100000)
                        quest:setVar(player, 'Prog', 2)
                        quest:setVar(player, 'Option', getVanaMidnight())
                    elseif option == 100 then
                        player:messageSpecial(zones[player:getZoneID()].text.QUEST_CANCELLED)
                        quest:setVar(player, 'Prog', 0)
                        quest:setVar(player, 'Option', 0)
                        player:setVar("BstHeadGearQuest_Conquest", 0)
                        player:setVar("BstHeadgearQuest", 0)
                        player:delQuest(xi.quest.log_id.OTHER_AREAS, xi.quest.id.otherAreas.A_GENEROUS_GENERAL)
                    end
                end,

                [775] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    npcUtil.giveItem(player, xi.items.GOBLIN_COIF_CUTTING)
                    quest:setMustZone(player) -- cap shows must zone before getting a new one if dropped/lost
                end,
            },
        },

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            onZoneIn =
            {
                function(player, prevZone)
                    local pos = player:getPos()
                    local headEquip = player:getEquipID(xi.slot.HEAD)
                    if
                        pos.x >= -323.0 and
                        pos.y >= 6.0 and
                        pos.z >= -261.0 and
                        pos.x <= -321.0 and
                        pos.y <= 9.0 and
                        pos.z <= -258.0 and
                        quest:getVar(player, 'Prog') == 3 and
                        headEquip == xi.items.GOBLIN_COIF
                    then
                        return 61
                    elseif quest:getVar(player, 'Prog') == 7 then
                        return 65
                    end
                end,
            },

            ['Iron_Box'] =
            {
                onTrigger = function(player, npc, trade)
                    local headEquip = player:getEquipID(xi.slot.HEAD)
                    if
                        headEquip == xi.items.GOBLIN_COIF and
                        player:hasKeyItem(xi.ki.GOBLIN_RECOMMENDATION_LETTER)
                    then
                        return quest:progressEvent(62)
                    elseif
                        headEquip == (xi.items.GOBLIN_COIF) and
                        quest:getVar(player, 'Prog') == 5
                    then
                        return quest:progressEvent(63)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        npcUtil.tradeHasExactly(trade, { xi.items.GOBLIN_COIF }) and
                        quest:getVar(player, 'Prog') == 6
                    then
                        return quest:progressEvent(64)
                    end
                end,
            },

            onEventFinish =
            {
                [61] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.GOBLIN_RECOMMENDATION_LETTER)
                    quest:setVar(player, 'Prog', 4)
                end,

                [62] = function(player, csid, option, npc)
                    if npcUtil.popFromQM(player, npc, spawnedMobs, { hide = 0 }) then
                        player:messageSpecial(oldton.text.RECOMMENDATION_LETTER)
                    end
                end,

                [63] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 6)
                end,

                [64] = function(player, csid, option, npc)
                        player:confirmTrade()
                        player:setVar("BstHeadGearQuest_Conquest", getConquestTally())
                        quest:setVar(player, 'Prog', 7)
                        npcUtil.giveItem(player, xi.items.CHOPLIXS_COIF)
                end,

                [65] = function(player, csid, option, npc) --Zone out and back into Oldton Movalpolos for a cutscene that ends the quest and a Gold Beastcoin reward.
                    if quest:complete(player) then
                        player:setVar("BstHeadgearQuest", 0)
                    end
                end,
            },

            ['Goblin_Preceptor'] =
            {
                onMobDeath = function(mob, player, optParams)
                    for i = oldton.mob.GOBLIN_PRECEPTOR + 1, oldton.mob.GOBLIN_PRECEPTOR + 6 do
                        DespawnMob(i)
                    end

                    if quest:getVar(player, 'Prog') == 4 then
                        quest:setVar(player, 'Prog', 5)
                        player:delKeyItem(xi.ki.GOBLIN_RECOMMENDATION_LETTER)
                    end
                end,
            }
        },
    },
}

return quest
