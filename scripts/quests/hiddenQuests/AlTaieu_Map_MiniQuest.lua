---------------------------------------------
-- Al'Taieu Map Mini-Quest
---------------------------------------------
-- Log ID: N/A
-- Quasilumin [1-20]
-- !gotoname Quasilumin <1-20>
---------------------------------------------
require('scripts/globals/zone')
require('scripts/globals/quests')
require('scripts/globals/npc_util')
require('scripts/globals/interaction/hidden_quest')
---------------------------------------------
local ID = require("scripts/zones/AlTaieu/IDs")
---------------------------------------------
local quest = HiddenQuest:new("AlTaieuMap")
local progTrackingVar = "Prog"
local completionTrackingVar = "IsComplete"
local completedBitValue = 1048575

local getQuasiluminDialogId = function(npc)
    local npcIndex = npc:getID() - ID.npc.QUASILUMIN_OFFSET

    -- Account for dialog ID shift at index 15
    if npcIndex >= 15 then
        npcIndex = npcIndex + 1
    end

    return (ID.text.QUASILUMIN_BASE_DIALOG + npcIndex)
end

quest.reward =
{
    keyItem = xi.ki.MAP_OF_ALTAIEU,
}

quest.sections =
{
    {
        check = function(player, status, vars)
            return (not player:hasKeyItem(xi.ki.MAP_OF_ALTAIEU))
        end,

        [xi.zone.ALTAIEU] =
        {
            ['Quasilumin'] =
            {
                onTrigger = function(player, npc)
                    local npcIndex = npc:getID() - ID.npc.QUASILUMIN_OFFSET
                    local currentProg = quest:getVar(player, progTrackingVar)

                    if currentProg == completedBitValue then -- Player has spoken to all Quasilumin and once more
                        quest:setVar(player, completionTrackingVar, 1)

                        return quest:messageSpecial(ID.text.QUASILUMIN_MAP_REWARD_DIALOG)
                    end

                    if not quest:isVarBitsSet(player, progTrackingVar, npcIndex) then
                        quest:setVarBit(player, progTrackingVar, npcIndex)
                    end

                    return quest:message(getQuasiluminDialogId(npc))
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return (quest:getVar(player, completionTrackingVar) == 1 and not player:hasKeyItem(xi.ki.MAP_OF_ALTAIEU))
        end,

        [xi.zone.ALTAIEU] =
        {
            ['Quasilumin'] =
            {
                onTrigger = function(player, npc)
                    quest:complete(player) -- Award the player their Map of Al'Taieu and clear quest vars
                    return
                end,
            },
        },
    },

    {
        check = function(player, status, vars)
            return player:hasKeyItem(xi.ki.MAP_OF_ALTAIEU)
        end,

        [xi.zone.ALTAIEU] =
        {
            ['Quasilumin'] =
            {
                onTrigger = function(player, npc)
                    return quest:message(getQuasiluminDialogId(npc))
                end,
            },
        },
    },
}

return quest
