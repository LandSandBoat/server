-----------------------------------
-- One Good Deed?
-----------------------------------
-- Log ID: 2, Quest ID: 92
-- Chipmy-Popmy !pos -181.466 -2.834 73.57
-- qm_deed      !pos -321.364 -2.591 -738.066
-----------------------------------
local bayID = zones[xi.zone.BIBIKI_BAY]
-----------------------------------

local quest = Quest:new(xi.questLog.WINDURST, xi.quest.id.windurst.ONE_GOOD_DEED)

quest.reward =
{
    exp     = 2000,
    gil     = 3200,
    keyItem = xi.ki.MAP_OF_THE_ATTOHWA_CHASM,
    title   = xi.title.DEED_VERIFIER,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return status == xi.questStatus.QUEST_AVAILABLE and
                player:getFameLevel(xi.fameArea.WINDURST) >= 5
        end,

        [xi.zone.PORT_WINDURST] =
        {
            ['Chipmy-Popmy'] = quest:progressEvent(594),

            onEventFinish =
            {
                [594] = function(player, csid, option, npc)
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

        [xi.zone.PORT_WINDURST] =
        {
            ['Chipmy-Popmy'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')

                    if progress == 0 then
                        return quest:event(596)
                    elseif progress == 1 then
                        return quest:progressEvent(595, 0, xi.ki.DEED_TO_PURGONORGO_ISLE)
                    elseif progress == 3 then
                        return quest:progressEvent(597)
                    else
                        return quest:event(599)
                    end
                end,
            },

            onEventFinish =
            {

                [595] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 2)
                end,

                [597] = function(player, csid, option, npc)
                    quest:complete(player)
                end,
            },
        },

        [xi.zone.BIBIKI_BAY] =
        {
            ['qm_deed'] =
            {
                onTrigger = function(player, npc)
                    local progress = quest:getVar(player, 'Prog')
                    local nmKilled = player:getLocalVar('NMKilled')

                    if
                        progress == 0 and
                        nmKilled == 0 and
                        not GetMobByID(bayID.mob.PEERIFOOL):isSpawned() and
                        not GetMobByID(bayID.mob.PEERIFOOL + 1):isSpawned() and
                        not GetMobByID(bayID.mob.PEERIFOOL + 2):isSpawned() and
                        not GetMobByID(bayID.mob.PEERIFOOL + 3):isSpawned() and
                        not GetMobByID(bayID.mob.PEERIFOOL + 4):isSpawned() and
                        not GetMobByID(bayID.mob.PEERIFOOL + 5):isSpawned()
                    then
                        for i = 0, 5 do
                            SpawnMob(bayID.mob.PEERIFOOL + i):updateClaim(player)
                        end

                        player:messageSpecial(bayID.text.IT_WAS_A_TRAP)
                        return quest:messageSpecial(bayID.text.YOU_ARE_NOT_ALONE)
                    elseif
                        progress == 0 and
                        nmKilled == 6
                    then
                        return quest:progressCutscene(34)
                    end
                end,
            },

            onEventFinish =
            {

                [34] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 1)
                    npcUtil.giveKeyItem(player, xi.ki.DEED_TO_PURGONORGO_ISLE)
                end,
            },

            ['Peerifool'] =
            {
                onMobDeath = function(mob, player, optParams)
                    local nmKilled = player:getLocalVar('NMKilled')

                    if quest:getVar(player, 'Prog') == 0 then
                        player:setLocalVar('NMKilled', nmKilled + 1) -- Resets upon zoning causing the player to need to refight the NMs
                    end
                end,
            },
        },

        [xi.zone.BONEYARD_GULLY] =
        {
            afterZoneIn = function(player)
                if quest:getVar(player, 'Prog') == 2 then
                    return quest:progressEvent(8, 4, xi.ki.DEED_TO_PURGONORGO_ISLE, 0, 274, 8)
                end
            end,

            onEventUpdate =
            {
                [8] = function(player, csid, option, npc)
                    if option == 101 then
                        player:updateEvent(3, xi.ki.MAP_OF_THE_ATTOHWA_CHASM, 0, 274, 8)
                    end
                end,
            },

            onEventFinish =
            {
                [8] = function(player, csid, option, npc)
                    quest:setVar(player, 'Prog', 3)
                    npcUtil.giveKeyItem(player, xi.ki.MAP_OF_THE_ATTOHWA_CHASM)
                end,
            },
        },
    },

    {
    check = function(player, status, vars)
        return status == xi.questStatus.QUEST_COMPLETED
    end,

    [xi.zone.PORT_WINDURST] =
        {
            ['Chipmy-Popmy'] = quest:event(598),
        },
    },
}

return quest
