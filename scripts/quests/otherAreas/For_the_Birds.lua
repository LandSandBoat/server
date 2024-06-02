-----------------------------------
-- For the Birds
-----------------------------------
-- Log ID: 4, Quest ID: 104
-- Koblakiq          !pos -64 21 -117 11
-- Daa Bola the Seer !pos -157 -17 193 151
-- GeFhu Yagudoeye   !pos -91 -3 -127 147
-----------------------------------
local oztrojaID  = zones[xi.zone.CASTLE_OZTROJA]
local beadeauxID = zones[xi.zone.BEADEAUX]
-----------------------------------
local quest = Quest:new(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.FOR_THE_BIRDS)

quest.reward =
{
    item = xi.item.JAGUAR_MANTLE,
}

local mobListTable =
{
    beadeauxID.mob.MAGNES_QUADAV,
    beadeauxID.mob.MAGNES_QUADAV + 1,
    beadeauxID.mob.MAGNES_QUADAV + 2,
    beadeauxID.mob.MAGNES_QUADAV + 3,
}

local function assignPlayer(player)
    for mobId = beadeauxID.mob.MAGNES_QUADAV, beadeauxID.mob.MAGNES_QUADAV + 3 do
        local mob = GetMobByID(mobId)
        mob:setLocalVar('PLAYERID', player:getID())
    end
end

local function allDead()
    for mobId = beadeauxID.mob.MAGNES_QUADAV, beadeauxID.mob.MAGNES_QUADAV + 3 do
        local mob = GetMobByID(mobId)
        if not mob:isDead() then
            return false
        end
    end

    return true
end

local function mobDeathCheck(mob, player)
    if
        quest:getVar(player, 'Prog') == 2 and
        allDead() and
        not player:hasKeyItem(xi.ki.GLITTERING_FRAGMENT) and
        mob:getLocalVar('PLAYERID') == player:getID()
    then
        quest:setVar(player, 'Prog', 3)
    end
end

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:hasCompletedQuest(xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.MISSIONARY_MOBLIN) and
                not quest:getMustZone(player)
        end,

        [xi.zone.OLDTON_MOVALPOLOS] =
        {
            ['Koblakiq'] = quest:progressEvent(14, { [1] = xi.item.ARNICA_ROOT }),

            onEventFinish =
            {
                [14] = function(player, csid, option, npc)
                    if option == 1 then
                        quest:begin(player)
                    end
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
                    local questProgress = quest:getVar(player, 'Prog')

                    if questProgress == 0 then
                        return quest:progressEvent(15, { [1] = xi.item.ARNICA_ROOT })
                    elseif
                        questProgress == 1 and
                        not player:hasKeyItem(xi.ki.GLITTERING_FRAGMENT)
                    then
                        return quest:progressEvent(16, { [1] = xi.ki.GLITTERING_FRAGMENT })
                    elseif questProgress == 4 then
                        return quest:progressEvent(18)
                    elseif player:hasKeyItem(xi.ki.GLITTERING_FRAGMENT) then
                        return quest:event(17)
                    elseif questProgress == 2 then -- player does not have ki after losing fight if questProgress = 2
                        npcUtil.giveKeyItem(player, xi.ki.GLITTERING_FRAGMENT)
                        return quest:progressEvent(17)
                    end
                end,
            },

            onEventFinish =
            {
                [16] = function(player, csid, option, npc)
                    npcUtil.giveKeyItem(player, xi.ki.GLITTERING_FRAGMENT)
                    quest:setVar(player, 'Prog', 2)
                end,

                [18] = function(player, csid, option, npc)
                    if quest:complete(player) then
                        xi.quest.setMustZone(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.BETTER_THE_DEMON_YOU_KNOW) -- must zone prior to For the Birds
                    end
                end,
            },
        },

        [xi.zone.CASTLE_OZTROJA] =
        {
            ['Daa_Bola_the_Seer'] =
            {
                onTrigger = function(player, npc)
                    if quest:getVar(player, 'Prog') == 0 then
                        return quest:event(86)
                    else
                        return quest:messageName(oztrojaID.text.LETTING_YOU_GO)
                    end
                end,

                onTrade = function(player, npc, trade)
                    if
                        quest:getVar(player, 'Prog') == 0 and
                        npcUtil.tradeHasExactly(trade, { xi.item.ARNICA_ROOT })
                    then
                        return quest:progressEvent(87, { [1] = xi.item.ARNICA_ROOT })
                    end
                end,
            },

            onEventFinish =
            {
                [87] = function(player, csid, option, npc)
                    player:tradeComplete()
                    quest:setVar(player, 'Prog', 1)
                end,
            },
        },

        [xi.zone.BEADEAUX] =
        {
            ['GeFhu_Yagudoeye'] =
            {
                onTrigger = function(player, npc)
                    if
                        quest:getVar(player, 'Prog') == 2 and
                        player:hasKeyItem(xi.ki.GLITTERING_FRAGMENT) and
                        npcUtil.popFromQM(player, npc, mobListTable, { claim = true, hide = 0, })
                    then
                        assignPlayer(player)
                        player:delKeyItem(xi.ki.GLITTERING_FRAGMENT)
                        player:messageSpecial(beadeauxID.text.GLITTERING_FRAGMENT_STOLEN, 0, xi.ki.GLITTERING_FRAGMENT)
                        return player:messageSpecial(beadeauxID.text.THE_QUADAV_ARE_ATTACKING)
                    elseif quest:getVar(player, 'Prog') == 3 then
                        return quest:progressEvent(124)
                    elseif quest:getVar(player, 'Prog') == 4 then
                        return quest:messageName(beadeauxID.text.HU_URR)
                    end
                end,
            },

            ['Nickel_Quadav'] =
            {
                onMobDeath = function(mob, player, optParams)
                    mobDeathCheck(mob, player)
                end,
            },

            ['Magnes_Quadav'] =
            {
                onMobDeath = function(mob, player, optParams)
                    mobDeathCheck(mob, player)
                end,
            },

            onEventFinish =
            {
                [124] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 4)
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
            ['Koblakiq'] =
            {
                onTrigger = function(player, npc)
                    if xi.quest.getMustZone(player, xi.questLog.OTHER_AREAS, xi.quest.id.otherAreas.BETTER_THE_DEMON_YOU_KNOW) then
                        return quest:event(19)
                    end
                end,
            },
        },
    },
}

return quest
