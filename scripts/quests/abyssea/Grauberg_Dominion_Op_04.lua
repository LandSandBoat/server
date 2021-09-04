-----------------------------------
-- Grauberg - Dominion Op #04
-----------------------------------
-- !addquest 8 118
-- Dominion Sergeant : !pos -15.513 0.64 -482.04 254
-----------------------------------
require('scripts/globals/interaction/quest')
require('scripts/globals/abyssea/dominion')
require('scripts/globals/npc_util')
require('scripts/globals/quests')
-----------------------------------

local quest = Quest:new(xi.quest.log_id.ABYSSEA, xi.quest.id.abyssea.DOMINION_OP_04_GRAUBERG)
--[[
local opInfo =
{
    opId = 591,
    reqZone = xi.zone.ABYSSEA_GRAUBERG,
}
]]--
quest.reward = {}

quest.sections =
{
    {

    },
}

return quest
